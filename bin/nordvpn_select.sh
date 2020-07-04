#!/bin/bash

sudo systemctl start nordvpnd.service

case $1 in
	"default") nordvpn c;;
	"Chicago") nordvpn c Chicago;;
	"Toronto") nordvpn c Toronto;;
	"London") nordvpn c London;;
	"quit") nordvpn d && sudo systemctl stop nordvpnd.service;;
	*) ;;
esac
