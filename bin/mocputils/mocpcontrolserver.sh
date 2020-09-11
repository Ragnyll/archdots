#!/bin/bash
# A utility script for mocp server for functions not easily accesible via CLI

# takes an argument $1 for what action to send the mocp server.
# $2 varies based on

mocp --server

function add_songs_in_playlist() {
        for SONG in $(cat $1); do
            mocp --enqueue $SONG
        done
}

case $1 in
    enqueue_song)
        mocp --enqueue $2
        ;;
    enqueue_playlist)
        add_songs_in_playlist $2
        ;;
    start_playslist)
        # kill server then rest art just the playlist passed
        mocp --exit && sleep 1
        mocp -S
        add_songs_in_playlist $2
        ;;
    *)
        echo "$1 option not recognized"
        ;;
esac

