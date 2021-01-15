# Custom ranger commands

from __future__ import (absolute_import, division, print_function)

import os
from os import getxattr, setxattr, listxattr, removexattr

from ranger.api.commands import Command
from gnupg import GPG

import tarfile
from time import sleep
import subprocess


def append_xattr_to_file(fname, xattr_val, xattr_key='user.tags'):
    """:append_xattr_to_file
    Appends an arbritary exif metadata tag to the specified attribute

    :fname (str): the file to append the exif metadata to
    :xattr_val (str): the value to append to the xattr_key
    :xattr_key (str): the
    """
    if xattr_key in listxattr(fname):
        xattrs = getxattr(fname, xattr_key).decode('utf-8').split(',')
        xattrs.append(xattr_val)
        setxattr(fname, xattr_key, bytes(','.join(set(xattrs)), 'utf-8'))
        return

    setxattr(fname, xattr_key, bytes(xattr_val, 'utf-8'))


def remove_xattr_from_file(fname, xattr):
    """:remove_file
    removes arbritary exif metadata xattr

    :fname (str): the file to append the exif metadata to
    :xattr_key (str): the xattr to remove
    """
    if xattr in listxattr(fname):
        removexattr(fname, xattr)


def remove_xattr_value_from_file(fname, xattr_val, xattr_key='user.tags'):
    """:append_tag_to_file
    Appends an arbritary exif metadata xattr to the specified attribute

    :fname (str): the file to append the exif metadata to
    :xattr_val (str): the value to append to the xattr_key
    :xattr_key (str): the
    """
    if xattr_key in listxattr(fname):
        xattrs = getxattr(fname, xattr_key).decode('utf-8').split(',')
        try:
            xattrs.remove(xattr_val)
        except ValueError:
            # if the tag doesnt exist just move on with it
            pass

        setxattr(fname, xattr_key, bytes(','.join(set(xattrs)), 'utf-8'))

        if not getxattr(fname, xattr_key).decode('utf-8'):
            try:
                removexattr(fname, xattr_key)
            except OSError:
                pass

        return


class encrypt(Command):
    """:encrypt

    Encrypts a file or dir (as a tar.gz) with the default gpg key
    """

    def tardir(self, path):
        """:tardir

        tars a directory into a dir of the same name appended with .tar.gz

        returns the name of the tarfile
        """
        output_path = path + '.tar.gz'

        with tarfile.open(output_path, "w:gz") as tar_handle:
            for root, dirs, files in os.walk(path):
                for file in files:
                    tar_handle.add(os.path.join(root, file))

        return output_path

    def get_default_pub_key(self, gpg_home):
        """

        returns False if the default_key was not found
        """
        with open(os.path.join(gpg_home, 'gpg.conf'), 'r') as gpg_conf:
            line = [line for line in gpg_conf.readlines() if 'default-key' in line]
            if not line:
                return False

        return line[0].split(' ')[1][:-1]

    def execute(self):
        gpg_home = os.path.join(os.path.expanduser('~'), '.gnupg/')
        default_key = self.get_default_pub_key(gpg_home)

        if not default_key:
            self.fm.notify('default-key configuration could not be found in ~/.gnupg/gpg.conf')
            return

        gpg = GPG(gpgbinary='/usr/bin/gpg', gnupghome=gpg_home)

        paths = [os.path.basename(f.path) for f in self.fm.thistab.get_selection()]

        for p in paths:
            if os.path.isdir(p):
                new_p = self.tardir(p)
                subprocess.run(['rm', '-rf', p])
                p = new_p

            with open(p, 'rb') as f:
                enc = gpg.encrypt_file(f, default_key)

            with open(p + '.gpg', 'wb+') as out:
                out.write(enc.data)

            if os.path.isfile(p):
                os.remove(p)


class decrypt(Command):
    """:decrypts

    Decrypts a file with gpg or a directory by extracting a tar file and decrypting it

    passing true as the false flag will not delete the origin gpg file
    """

    def execute(self):
        gpg = GPG(gnupghome=os.path.join(os.path.expanduser('~'), '.gnupg'))

        paths = [os.path.basename(f.path) for f in self.fm.thistab.get_selection()]

        for p in [p for p in paths if p.endswith('gpg')]:
            with open(p, 'rb') as enc:
                dec_b = gpg.decrypt_file(enc)

            out_fname = os.path.splitext(p)[0]
            with open(out_fname, 'wb+') as dec_f:
                dec_f.write(dec_b.data)

            if self.arg(1) != 'true':
                os.remove(p)

            if tarfile.is_tarfile(out_fname):
                tarfile.open(out_fname).extractall(path='.')
                os.remove(out_fname)


class add_tag(Command):
    """:add_tag

    Appends an arbitrary tag to the exif metadata 'user.tags' attribute
    """
    def execute(self):
        if not self.arg(1):
            self.fm.notify("Provide the tag to add to the selected files.")
            return
        filenames = [f.path for f in self.fm.thistab.get_selection()]

        for f in filenames:
            append_xattr_to_file(f, str(self.arg(1)), 'user.tags')


class remove_tag(Command):
    """:add_tag

    Removes an arbitrary tag from the exif metadata 'user.tags' attribute
    """
    def execute(self):
        if not self.arg(1):
            self.fm.notify("Provide the tag to remove from the selected files.")
            return
        filenames = [f.path for f in self.fm.thistab.get_selection()]

        for f in filenames:
            remove_xattr_value_from_file(f, str(self.arg(1)), 'user.tags')

        self.fm.notify('{} user.tags removed from file[s]'.format(self.arg(1)))


class remove_xattr(Command):
    """:add_tag

    Removes an arbitrary tag from the exif metadata 'user.tags' attribute
    """
    def execute(self):
        if not self.arg(1):
            self.fm.notify("Provide the xattr to remove from the selected files.")
            return
        filenames = [f.path for f in self.fm.thistab.get_selection()]

        for f in filenames:
            try:
                removexattr(f, str(self.arg(1)))
            except OSError:
                pass

        self.fm.notify('{} user.tags removed from file[s]'.format(self.arg(1)))


class fzf_select(Command):
    """
    :fzf_select

    Find a file using fzf.

    With a prefix argument select only directories.

    See: https://github.com/junegunn/fzf
    """
    def execute(self):
        import subprocess
        import os.path
        if self.quantifier:
            # match only directories
            command = "find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -type d -print 2> /dev/null | sed 1d | cut -b3- | fzf +m"
        else:
            # match files and directories
            command = "find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -print 2> /dev/null | sed 1d | cut -b3- | fzf +m"
        fzf = self.fm.execute_command(command, universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)


class mocp_playlist_add(Command):
    """:mocp_playlist_add

    Adds selected files to a playlist file in ~/Music/playlists/.
    If the playlist named does not exist it creates it.

    *songs is the selected files

    usage: playlist_name
    """

    def execute(self):
        from glob import glob

        if not self.arg(1):
            self.fm.notify("Provide the name of a playlist")
            return

        #  self.fm.notify("The home dir is " + os.path.expanduser("~"))
        default_playlist_path = os.path.join(os.path.expanduser("~"), "Music/playlists/")
        target_playlist = os.path.join(default_playlist_path, self.arg(1) + ".playlist")

        selection = [f.path for f in self.fm.thistab.get_selection()]

        with open(target_playlist, 'a') as playlist_file:
            for file_path in selection:

                # TODO: recursive directory add still has trouble
                if os.path.isdir(file_path):
                    files_in_dir = [y for x in os.walk(file_path) for y in glob(os.path.join(x[0], '*'))]
                    for audio_file_path in files_in_dir:
                        audio_file_path.write(file_path + '\n')
                else:
                    playlist_file.write(file_path + '\n')

    def tab(self, tabnum):
        """Lists existing *.playlist files in ~/Music/playlists/ allowing the user to tab through existing playlists.
        """
        pass

    def is_audio_file(fp):
        """checks if a file is of an audio file type based off its magic numbers

        NOTE: requires https://github.com/h2non/filetype.py be installed at the system level
        """
        #  import filetype
        pass
