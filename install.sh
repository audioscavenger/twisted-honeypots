#!/bin/bash

apk --update --upgrade add git python3 py3-pip python3-dev curl sudo geoip libc-dev linux-headers libffi-dev openssl-dev

pip3 install -r requirements.txt --user --upgrade
