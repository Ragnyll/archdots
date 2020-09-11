# Custom ranger commands

from __future__ import (absolute_import, division, print_function)

import os

from ranger.api.commands import Command


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
        import filetype
        pass
