#!/bin/bash
export PATH=$PATH:/root/.local/bin

apk --update --upgrade add git python3 py3-pip python3-dev curl sudo geoip libc-dev linux-headers libffi-dev openssl-dev mariadb-dev
pip install --upgrade pip

# TODO: test wheeled install: virtualenv --python=python3 -r requirements.txt --user --upgrade
pip3 install -r requirements.txt --user --upgrade
