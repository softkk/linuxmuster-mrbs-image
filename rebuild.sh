#!/bin/bash

git status
php_version=$(cat php_version.txt)
git commit -a -m"linuxmuster-mrbs: php version: $php_version" 

docker pull php:apache
docker inspect php:apache | grep RepoTags -A 3
git_log=$(git log --oneline | head -1 | cut -d " " -f 1)
echo "now build with: docker build -t hgkvplan/linuxmuster-mrbs:$php_version-$git_log ."
