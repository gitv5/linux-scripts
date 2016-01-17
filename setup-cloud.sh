#!/bin/bash
# Dette script er beregnet til at blive kørt som root!
# Det er meningen at det kun skal køres en enkel gang for at komme hurtigt
# igang med sin nye v5 Cloud Server.
# Efter det kan man blot fjerne scriptet igen fra systemet.
# $ wget https://raw.githubusercontent.com/gitv5/linux-scripts/master/setup-cloud.sh
# $ chmod +x setup-cloud.sh
# $ ./setup-cloud.sh
# $ rm setup-cloud.sh

function ask() {
	read -p "$1 (j/N): "
	case $(echo $REPLY | tr '[A-Z]' '[a-z]') in
		j|ja) echo "yes";;
		*) echo "no";;
	esac
}

if [[ "yes" == $(ask "Vil du opdatere systemet?") ]]; then
	apt-get update && apt-get upgrade
fi

if [[ "yes" == $(ask "Vil du lave en ny bruger til dig selv?") ]]; then
	read -p "$1 Brugernavn: " && adduser $REPLY && gpasswd -a $REPLY sudo
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
