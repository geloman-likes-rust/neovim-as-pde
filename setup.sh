#!/bin/sh

## NEOVIM LATEST VERSION - STABLE
#---------------------------------------------------------------------
install_neovim() {
	[ -z "$(which nvim 2> /dev/null)" ] || return
	echo "Installing neovim......................................"
	cd "$HOME" && curl -s -JLO https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
	tar xzvf nvim-linux64.tar.gz
	rm -rdf nvim-linux64.tar.gz
	mv "$HOME"/nvim-linux64 "$HOME"/.neovim
	[ -d ~/.local ] || mkdir ~/.local
	[ -d ~/.local/bin ] || mkdir ~/.local/bin
	ln -s "$HOME"/.neovim/bin/nvim "$HOME"/.local/bin/
}

## MINICONDA - need this for local installations
#---------------------------------------------------------------------
install_miniconda() {
	[ -d ~/.miniconda ] && return
	echo "Installing miniconda......................................"
	curl -sSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o ~/miniconda.sh
	chmod +x ~/miniconda.sh
	~/miniconda.sh -b -p ~/.miniconda && echo "yes" | ~/.miniconda/bin/conda init
	rm -rdf ~/miniconda.sh
	. "$HOME"/.bashrc
}

## FD-FIND - need this for telescope live-grep
#---------------------------------------------------------------------
install_fd() {
	[ -z "$(which fd 2> /dev/null)" ] || return
	echo "Installing fd-find......................................"
	conda install -y -c conda-forge fd-find
}

## RIPGREP - need this for telescope live-grep
#---------------------------------------------------------------------
install_ripgrep() {
	[ -z "$(which rg 2> /dev/null)" ] || return
	echo "Installing ripgrep......................................"
	conda install -y -c conda-forge ripgrep
}

## creates symbolic-link --> .config/nvim
symlink_nvim() {
	ln -sf ~/.nvim/nvim ~/.config/
}

setup() {
	install_neovim
	install_miniconda
	install_fd
	install_ripgrep
	symlink_nvim
}

setup
