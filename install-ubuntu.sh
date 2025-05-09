#!/bin/bash

URL_NERD_FONTS=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip
PATH_TO_FONTS=/usr/local/share/fonts

# mac
# port install bat
# brew install fzf

echo "Installing some utilities: "
sudo apt -qq - y install terminator zsh vim vlc
echo "Fixing history for zsh"
touch ~/.zsh_history
chmod 600 ~/.zsh_history
echo "setopt APPEND_HISTORY" > ~/.zshrc
echo "setopt INC_APPEND_HISTORY" > ~/.zshrc
echo "setopt SHARE_HISTORY" > ~/.zshrc
echo "setopt HIST_IGNORE_DUPS" > ~/.zshrc
echo "setopt HIST_IGNORE_SPACE" > ~/.zshrc
echo "setopt HIST_SAVE_NO_DUPS" > ~/.zshrc
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
echo 'alias ls="lsd --group-dirs=last"' >> ~/.zshrc
# setting dir colors to violet to omit the default dark blue
echo 'export LS_COLORS="$LS_COLORS:di=01;36:"' >> ~/.zshrc
echo -n "Installing bat....\n"
wget -q -P ~/bat.deb https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-musl_0.24.0_amd64.deb
sudo dpkg -i ~/bat.deb/bat-musl_0.24.0_amd64.deb
rm ~/bat.deb
echo -ne "\033[2K[2K\rInstalling bat.... Done!\n"
echo 'alias cat="/usr/bin/bat --paging=never"' >> ~/.zshrc
echo 'alias catn="/usr/bin/cat"' >> ~/.zshrc
echo 'Add autocomplete to directories (may broke autosuggestions?)'
echo 'setopt auto_cd' >> ~/.zshrc
echo 'autoload -zU compinit' >> ~/.zshrc
echo 'compinit' >> ~/.zshrc

# PER USER
# Powerlevel10K
#sudo usermod --shell /usr/bin/zsh
echo "Installing fzf for current user"
git clone --quiet --depth=1 https://github.com/junegunn/fzf.git ~/.fzf
./.fzf/install
echo "Installing powerlevel10 for current user"
echo -n "Cloning repo from github.....\n"
git clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo -ne "\033[2K[2K\rCloning repo from github.....Done!\n"
echo -n "Adding sources to .zshrc.....\n"
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
echo -ne "\033[2K[2K\rAdding sources to .zshrc.....Done!\n"

echo -n "Installing zsh plugins....\n"
sudo apt-get -qq -y install zsh-autosuggestions
sudo chown inigo:inigo -R /usr/share/zsh-autosuggestions
echo 'source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
sudo apt-get -qq -y install zsh-syntax-highlighting
sudo chown inigo:inigo -R /usr/share/zsh-syntax-highlighting
echo 'source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc
echo -ne "\033[2K[2K\rInstalling zsh plugins.... Done!\n"

echo 'setopt append_history' >> ~/.zshrc
echo 'setopt hist_ignore_dups' >> ~/.zshrc
echo 'setopt share_history' >> ~/.zshrc

echo 'Changing current user`s shell to zsh'
sudo chsh -s /usr/bin/zsh $USER

echo "IMPORTANT: After finalization you have not configured p10k, you should do it after installation ends running the command:"
echo "p10k configure"
read -n 1 -s -r -p ""
echo "Resuming..."

echo "Installing docker"
echo "Uninstalling conflicting packages"
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
echo "Adding repos"
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl vim
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt install terminator
sudo apt install chomium-browser
sudo snap install gitkraken --classic
sudo snap install brave
sudo snap install intellij-idea-community --classic
sudo snap install android-studio --classic
echo "Install docker"
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Give permissions"
echo "Adding current user to docker group"
sudo groupadd docker
sudo usermod -aG docker $USER
echo "Restarting docker"
sudo systemctl restart docker

# Root
