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
