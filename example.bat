#!/bin/bash

## checking if the user is privileged or not

if [[ $EUID != 0 ]]
then
	echo "Script has to be ran as root or sudo"
	echo "Aborting"
	exit 101
fi

## creating help functions

function usage() {

echo "usage: ${0} -a <user> -p <password> -s <shell> | ${0} -d <user> | ${0} -h" 
	}

function help() {

echo -e "$0 - Script to add of remove users\n\t\
-a - Add a new user\n\t\
-p - Set password while creating user if not mentioned will not set any password by default\n\t\
-s - Set a shell for the user default is /bin/bash if none specified\n\
-a - Remove a user\n\
-h - Print this help text\n"
	}

if [[ "$#" -lt "1" ]]; then
       echo "Argument has to be provided see $0 -h"
fi       

shell=/bin/bash
password=$(openssl rand -base64 12)
while getopts :a:d:h opt; do 
	case $opt in 
	
		a) user=$OPTARG
			while getopts :p:s: test
			do
				case $test in 
					p) password=$OPTARG;;
					s) shell=$OPTARG;;
					/?) echo "The provided flag is not identified see $0 -h"
						exit;;
					:) echo "$OPTARG requires arguments see $0 -h"
				    	exit;;
				esac
			done
		if [[ "$1" != "-a" ]]
		then
			echo "You have to specify username using -a flag see $0 -h"
		fi
		useradd -m $user -s $shell
		echo "$user":"$password" | chpasswd
		echo "The password for the $user is $password";;
				
		d) userdel -f $OPTARG
			if [[ $? == 0 ]]
			then
				echo "user has been removed"
			else
				echo "There was some error removing the user"
			fi;;

		h) help
			exit;;
		/?) echo "$OPTARG option not valid";;
		:) echo "$OPTARG requires argument";;
	esac
done