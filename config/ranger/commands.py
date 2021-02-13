# Custom ranger commands

from __future__ import (absolute_import, division, print_function)

import os
from os import getxattr, setxattr, listxattr, removexattr
from pathlib import Path

from ranger.api.commands import Command


def append_xattr_to_file(fname, xattr_val, xattr_key='user.tags'):
    """:append_xattr_to_file
    Appends an arbritary exif metadata tag to the specified attribute

    :fname (str): the file to append the exif metadata to
    :xattr_val (str): the value to append to the xattr_key
    :xattr_key (str): the
    """
    # resolve to the actual path if a symlink
    resolved_fname = Path(fname).resolve()
    if xattr_key in listxattr(resolved_fname):
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
    # resolve to the actual path if a symlink
    resolved_fname = Path(fname).resolve()
    if xattr in listxattr(resolved_fname):
        removexattr(fname, xattr)


def remove_xattr_value_from_file(fname, xattr_val, xattr_key='user.tags'):
    """:append_tag_to_file
    Appends an arbritary exif metadata xattr to the specified attribute

    :fname (str): the file to append the exif metadata to
    :xattr_val (str): the value to append to the xattr_key
    :xattr_key (str): the
    """
    # resolve to the actual path if a symlink
    resolved_fname = Path(fname).resolve()
    if xattr_key in listxattr(resolved_fname):
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
