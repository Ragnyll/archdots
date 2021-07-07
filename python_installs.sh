#!/bin/bash
# Generic installs for pip and pythong

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py --user
rm get-pip.py

pip install \
attrs \
certifi \
distlib \
docopt \
filelock \
filetype \
fire \
moviepy \
python-magic \
pip \
pipenv \
python-xlib \
termcolor \
ueberzug \
virtualenv \
virtualenv-clone \
pynvim \
python-gnupg \
youtube_dl \
bpython \
wheel

