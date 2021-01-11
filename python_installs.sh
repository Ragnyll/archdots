#!/bin/bash
# Generic installs for pip and pythong

wget https://bootstrap.pypa.io/get-pip.py
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
pip \
pipenv \
python-xlib \
termcolor \
ueberzug \
virtualenv \
virtualenv-clone \
wheel

