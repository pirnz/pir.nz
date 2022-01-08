#!/bin/sh
git pull
rm -r public
hugo --minify
rm -r /mnt/hdd/data/pir.nz/*
cp -r public/* /mnt/hdd/data/pir.nz/
