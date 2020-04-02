#! /bin/bash

source "$HOME/dotfiles/scripts/pkg_man.sh"
source "$HOME/dotfiles/scripts/utils.sh"

mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share"


while getopts "hli:d" opt; do
	case ${opt} in
		h ) # help message
			echo "Usage: $0 [-h|-l|-i -d <distro>]
		-h:	print this help message
		-l:	list distro scripts available
		-i:	install
		-d:	select distro"
			exit 0
			;;
		i ) # action
			INSTALL=install
			;;
		d ) # distro select
			DISTRO=${OPTARG}
			;;
		l ) # distro list
			SCRIPT=$(readlink -f $0)
			DISTRO_SCRIPTS_PATH=${SCRIPT%/*}/os_scripts
			echo 'Available distros:'
			ls $DISTRO_SCRIPTS_PATH | sed 's/.sh//'
			;;
		* )
			exit -1
			;;
	esac
done

"$HOME"/dotfiles/os_scripts/"$DISTRO".sh "$INSTALL"
