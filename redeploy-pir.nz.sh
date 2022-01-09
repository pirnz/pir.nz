#!/bin/sh
git pull
rm -r public/
hugo --minify
rsync --recursive --delete --update public/ /mnt/hdd/data/pir.nz/
