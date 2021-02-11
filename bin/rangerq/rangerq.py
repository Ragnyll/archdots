#!/bin/python
from os import listdir, path
from random import choice
from subprocess import run
import sys
user_home = path.expanduser('~')
sys.path.append(path.join(user_home, 'bin'))
import tag_utils


def exclude_files_with_tags(files):
    pass


def symlink_included_files_to_temp_dir():
    pass


def open_ranger():
    pass


def open_custom_ranger_buffer(tags_to_include, tags_to_exclude, start_dir='.', xattr='user.tags'):
    """Opens ranger
    """
    files = tag_utils.get_files_with_metadata_tag(start_dir, xattr_value, xattr)
    omit_files_with_tag(f, tags_to_exclude, xattr_key_to_exclude='user.tags')
    symlink_included_files_to_temp_dir()
    open_ranger()
    print('boss')
    pass


if __name__ == '__main__':
    import fire

    fire.Fire({
        'query': open_custom_ranger_buffer
    })
