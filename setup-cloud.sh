#!/bin/bash

function ask() {
	read -p "$1 (j/N): "
	case $(echo $REPLY | tr '[A-Z]' '[a-z]') in
		j|ja) echo "yes";;
		*) echo "no";;
	esac
}

if [[ "yes" == $(ask "Vil du opdatere systemet?") ]]
then
	apt-get update && apt-get upgrade
fi

if [[ "yes" == $(ask "Vil du lave en ny bruger til dig selv?") ]]; then
	read -p "$1 Brugernavn: "
	adduser $REPLY && gpasswd -a $REPLY sudo
fi

if [[ "yes" == $(ask "Slå root fra?") ]]; then
	sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config && service ssh restart
fi

if [[ "yes" == $(ask "Installer vim?") ]]; then
	apt-get install vim
fi

if [[ "yes" == $(ask "Vil du ændre din standard editor?") ]]; then
	update-alternatives --config editor
fi
