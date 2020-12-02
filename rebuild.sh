#!/bin/bash

git status
php_version=$(cat php_version.txt)
if ! grep $php_version Dockerfile ; then
    echo "$php_version not in Dockerfile, fixing this";
    sed -i "s/^FROM\ php.*/FROM php:${php_version}/" Dockerfile
fi
mrbs_version=$(cat mrbs_version.txt)
grep $mrbs_version Dockerfile || { echo "$mrbs_version not in Dockerfile, please fix"; exit 1 ; }
git commit -a -m"linuxmuster/mrbs: php version: $php_version, mrbs version: $mrbs_version" 

docker pull php:7-apache
docker inspect php:7-apache | grep RepoTags -A 3
git_log=$(git log --oneline | head -1 | cut -d " " -f 1)
echo "Press enter to build with: docker build -t linuxmuster/mrbs-${mrbs_version}:$php_version-$git_log ."
read
docker build -t linuxmuster/mrbs-${mrbs_version}:$php_version-$git_log .
docker tag linuxmuster/mrbs-${mrbs_version}:$php_version-$git_log linuxmuster/mrbs-${mrbs_version}:latest
echo "Try if :latest works for you. Then press enter to tag and upload using"
echo "docker tag linuxmuster/mrbs-${mrbs_version}:$php_version-$git_log linuxmuster/mrbs-${mrbs_version}:working"
echo "docker push linuxmuster/mrbs-${mrbs_version}:$php_version-$git_log ; docker push linuxmuster/mrbs-${mrbs_version}:latest"
read
docker tag linuxmuster/mrbs-${mrbs_version}:$php_version-$git_log linuxmuster/mrbs-${mrbs_version}:working
docker push linuxmuster/mrbs-${mrbs_version}:$php_version-$git_log ; docker push linuxmuster/mrbs-${mrbs_version}:latest

