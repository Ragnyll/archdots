"""Some wrapper utilities for file system tricks with attributes
"""
from glob import glob
from os import path, getxattr, listxattr


def get_xattr_value_as_list(fpath, xattr):
    """returns the values set on the xattr as a list of str (splitting by ',')
    returns an empty list if the xattr does not exist on the target fpath

    fpath (str): the path of the file to get xattr on
    xattr (str): the xattr to get the values from
    """
    if xattr in listxattr(fpath):
        return getxattr(fpath, xattr).decode('utf-8').split(',')
    else:
        return []


def get_files_with_metadata_tag(start_dir, xattr_value, xattr_key='user.tags'):
    """Returns a list of files with the supplied metadata tag

    start_dir(str): the directory to start searching recursively through
    xattr_key(str): the key to search for the supplied xattr_value in. defaults to user.tags
    xattr_value(str): the attribute to find contained in xattrkey

    """
    pattern = path.join(start_dir, '**', '*')
    fnames = [fname for fname in glob(pattern, recursive=True) if path.isfile(fname) and xattr_value in get_xattr_value_as_list(fname, xattr_key)]
    return fnames


def remove_files_to_omit(filepaths, xattr_values_to_exclude, xattr_key_to_exclude='user.tags'):
    """returns a subset of filepaths that do not include the xattr_{key,_value}


    :filepaths (list): a list of file paths
    xattr_values_to_exclude(list(str)): the attribute to find contained in xattrkey
    xattr_key(str): the key to search for the supplied xattr_value in. defaults to user.tags
    """
    cleaned_files = []
    for f in filepaths:
        if set(get_xattr_value_as_list(f, xattr_key_to_exclude)).intersection(set(xattr_values_to_exclude)):
            cleaned_files.append(f)

    return cleaned_files


def query_files(start_dir, xattr_value, xattr_values_to_exclude=[], xattr_key='user.tags'):
    files = get_files_with_metadata_tag(start_dir, xattr_value, xattr_key)
    return remove_files_to_omit(files, xattr_values_to_exclude, xattr_key)


if __name__ == '__main__':
    import fire  # fire should only be imported if this script is being used as an executable

    fire.Fire({
        'list': get_files_with_metadata_tag,
        'query': query_files,
    })
