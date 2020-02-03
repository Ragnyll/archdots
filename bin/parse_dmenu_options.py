#!/bin/python3
# a script to build a command to be run via dmenu when a finite number of options out of a single selection are allowed
# runs in tandem with the shell command:
# awk -F "\"*,\"*" '{print $1}' ~/bin/dmenu_commands | dmenu -sb "#9900cc" | ./execute_script.py options --file_name ~/bin/dmenu_commands | dmenu -sb "#9900cc"

import fire


def build_cmd_with_option(file_name):
    string_to_search = input()
    with open(file_name) as file:
        cmd_and_options = [line.rstrip() for line in file.readlines() if string_to_search in line]
    # there should only ever be one match based on how dmenu will return file names
    # this will break on commands where there are no options
    cmd = cmd_and_options[0].split(',')[1]
    options = cmd_and_options[0].split(',')[1:]
    for option in options:
        print(cmd + ' ' + option)


if __name__ == '__main__':
    fire.Fire({
        'cmd_to_run': build_cmd_with_option,
    })
