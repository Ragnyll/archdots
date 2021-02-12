#!/bin/bash

function rangerq_help() {
    echo "IMPORTANT! rangerq wraps ranger!"
    echo "ranger q is query tool to open up temporary file buffers of a fs query"
    echo "rangerq usage:"
    echo "rangerq [-q tag1,tag2,tagn] [-o tag1,tag2,tagn]"
}

function xattr_ranger_buffer() {
    # $1 a comma seperated list of xattributes to include in query
    rm -rf /tmp/rangerq/
    mkdir /tmp/rangerq

    while read -r p; do
        ln -s $(find "$(pwd)"/"$p" -type f) /tmp/rangerq/
    done < <(python ~/bin/xattr_utils.py list . $1)

    ranger /tmp/rangerq/
}


case "$#" in
    "0")
        ranger
        ;;
    "1")
        [ $1 == "-h" ] \
            && rangerq_help
        ranger "$@"
        ;;
    "2")
        [ $1 == "-q" ] \
            && xattr_ranger_buffer "${@:2}"  \
            || ranger "$@"
        ;;
    "3")
        [ $1 == "-q" ] && [ $3 == "-o" ] \
            && echo "rangerq query not yet supported" \
            || ranger "$@" && exit 0
        ;;
    *)
        ranger "@"
        ;;
esac
