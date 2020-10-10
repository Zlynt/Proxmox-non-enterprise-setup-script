#!/usr/bin/env bash

#Color codes for bash
BASH_RED='\033[0;31m'
BASH_BLUE='\033[0;34m'
BASH_GREEN='\033[0;32m'
BASH_WHITE='\033[0;37m'
DEBIAN_CODENAME=`cat /etc/os-release | grep VERSION_CODENAME | cut -d "=" -f2`


printf "\n${BASH_GREEN}===== PROXMOX NON ENTERPRISE SETUP =====${BASH_WHITE}\n\n"
printf "Made for Proxmox on date 10/10/2020!\n"
printf "Tested on Proxmox Virtual ENvironment 6.2-12\n\n"

read -p "Do you want to run the self configure script? (y/n) " action
if [ "$action" = "y" ]
then


	printf "Removing enterprise repo...\n"
	rm /etc/apt/sources.list.d/pve-enterprise.list &>/dev/null

	if [ grep "deb http://download.proxmox.com/debian/pve buster pve-no-subscription" /etc/apt/sources.list ]
	then

		printf "Adding non enterprise repo...\n"
		#File location : /etc/apt/sources.list
		echo deb http://download.proxmox.com/debian/pve $DEBIAN_CODENAME pve-no-subscription >>  /etc/apt/sources.list
	else
		printf "${BASH_GREEN}Non enterprise repo detected! Non enterprise repo was not added.${BASH_WHITE}\n"
	fi

	printf "Updating apt packages list...\n"
	apt update &>/dev/null
	printf "Upgrading apt packages...\n"
	apt -y dist-upgrade &>/dev/null
else
	printf "\n${BASH_RED}The script has not done anything!${BASH_WHITE}\n\n"
fi

printf "${BASH_GREEN}Proxmox Server is ready!${BASH_WHITE}\n\n"
echo Greetings from Zlynt!
