#!/bin/bash

URL_NERD_FONTS=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip
PATH_TO_FONTS=/usr/local/share/fonts

# COMMON
# Install fonts to be able to draw every unicode character
echo -n "Downloading fonts from internet....\n"
sudo wget -q -P $PATH_TO_FONTS $URL_NERD_FONTS && \
echo -ne "\033[2K[2K\rDownloading fonts from internet....Done!\n"
echo -n "Unzipping....\n"
sudo unzip -o -q $PATH_TO_FONTS/Hack.zip -d $PATH_TO_FONTS && \
echo -ne "\033[2K[2K\rUnzipping.... Done!\n"
echo -n "Removing....\n"
sudo rm $PATH_TO_FONTS/Hack.zip && \
echo -ne "\033[2K[2K\rRemoving.... Done!\n"
echo -n "Installing lsd....\n"
sudo apt-get -qq -y install lsd
echo -ne "\033[2K[2K\rInstalling lsd.... Done!\n"

# PER USER
# Powerlevel10K
sudo usermod --shell /usr/bin/zsh
echo "Installing powerlevel10 for current user"
echo -n "Cloning repo from github.....\n"
git clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo -ne "\033[2K[2K\rCloning repo from github.....Done!\n"
echo -n "Adding sources to .zshrc.....\n"
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
echo -ne "\033[2K[2K\rAdding sources to .zshrc.....Done!\n"

echo "IMPORTANT: After finalization you have not configured p10k, you should do it after installation ends running the command:"
echo "p10k configure"
read -n 1 -s -r -p ""
echo "Resuming"


# Root
sudo usermod --shell /usr/bin/zsh
echo "Installing powerlevel10 for current ROOT"
echo -n "Cloning repo from github.....\n"
git clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo -ne "\033[2K[2K\rCloning repo from github.....Done!\n"
echo -n "Adding sources to .zshrc.....\n"
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
echo -ne "\033[2K[2K\rAdding sources to .zshrc.....Done!\n"