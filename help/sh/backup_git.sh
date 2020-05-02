#!/usr/bin/env sh
cp ~/.bashrc ~/help/sh/
cd ~/help
git add .
git commit  -m  "$(date +%Y-%m-%d)备份"
git push -u origin master
