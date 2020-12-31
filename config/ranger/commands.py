# Custom ranger commands

from __future__ import (absolute_import, division, print_function)

import os

from ranger.api.commands import Command


class add_tag(Command):
    """:add_tag

    Appends a tag to the exif metadata 'user.tags' attribute
    """
    def execute(self):
        from os import getxattr, setxattr

        if not self.arg(1):
            self.fm.notify("Provide the tag to add to the selected files.")
            return
        filenames = [f.path for f in self.fm.thistab.get_selection()]

        for f in filenames:
            # get the existing xattributes as a list of strings
            xattrs = getxattr(f, 'user.tags').decode('utf-8').split(',')
            # add the new tag to the list and cast it to a set
            xattrs.append(str(self.arg(1)))
            # cast the list to a comma seperated string and cast to bytes and overwrite tags
            setxattr(f, 'user.tags', bytes(','.join(set(xattrs)), 'utf-8'))

        self.fm.notify('{} user.tags added to file[s]'.format(self.arg(1)))


class bookmark_bg(Command):
    """:bookmark_bg

    Adds a symlink from the target to the dir ~/Pictures/wallpapers/bookmarked/

    usage: bookmark_bg
    """
    def execute(self):
        from os import symlink
        from os import path

        user_home = path.expanduser('~')
        bookmark_dir = path.join(user_home, 'Pictures/wallpapers/bookmarked/')
        filenames = [f.path for f in self.fm.thistab.get_selection()]
        if not len(filenames):
            self.fm.notify("Please select file[s] to bookmark")
            return

        for f in filenames:
            self.fm.notify('symlinking {} to {}'.format(f, path.join(bookmark_dir, path.basename(f))))
            symlink(f, path.join(bookmark_dir, path.basename(f)))


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
