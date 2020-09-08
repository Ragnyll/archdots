#!/bin/bash

# Takes a file containing absolute paths to audio files seperated by newlines and puts them into a single line split by spaces

tr '\n' ' ' < $1
