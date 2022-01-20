#!/bin/sh
IP="192.168.1.$HOST"
root_path="/mnt/hdd/data/"
echo "Syncing ereader content at $IP"
sshpass -f $root_path/pir.nz/scripts/bookpass rsync --rsync-path=/mnt/secure/bin/rsync --progress --remove-source-files --update --verbose root@$IP:/mnt/ext1/Notes/* $root_path/pir.nz/static/thinks/books
sshpass -f $root_path/pir.nz/scripts/bookpass rsync --rsync-path=/mnt/secure/bin/rsync --progress --update --verbose $root_path/books/* root@$IP:/mnt/ext1/Libros
