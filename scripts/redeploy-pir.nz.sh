#!/bin/sh
git pull
rm -r public/*
hugo --minify
