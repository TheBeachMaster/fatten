#!/usr/bin/env sh
set -e
set -u

repoFilePath='/etc/yum.repos.d/fatten.repo'
repoFileContent='[fatten]
name=fatten
#baseurl=https://shellfire-dev.github.io/fatten/download/yum/fatten
mirrorlist=https://shellfire-dev.github.io/fatten/download/yum/fatten/mirrorlist
gpgkey=https://shellfire-dev.github.io/fatten/download/yum/fatten/RPM-GPG-KEY-fatten
gpgcheck=1
enabled=1
protect=0'

if [ -t 1 ]; then
	printf '%s\n' "This script will install the yum repository 'fatten'" "It will create or replace '$repoFilePath', update yum and display all packages in 'fatten'." 'Press the [Enter] key to continue.'
	read -r garbage
fi

printf '%s' "$repoFileContent" | sudo -p "Password for %p is required to allow root to install '$repoFilePath': " tee "$repoFilePath" >/dev/null
sudo -p "Password for %p is required to allow root to update yum cache: " yum --quiet makecache
yum --quiet info fatten 2>/dev/null
