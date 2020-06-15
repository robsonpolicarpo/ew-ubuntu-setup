##### PROGRAMS WILL BE INSTALLED #####################################################
# * CURL
# * SDKMAN + JAVA
# * GIT + CONFIG
# * PIP3
# * PYCHARM-CE
# * SUBLIME
# * FLAMESHOT
# * DBEAVER
# * AWS-CLI
# * DOCKER + DOCKER-COMPOSE
# * NVM + NPM + NODE


SNAP_PROGRAMS=$(snap list)
DPKG_PROGRAMS=$(dpkg --get-selections)
sudo apt update

echo "================================================================================"
echo "[$(date "+%Y/%m/%d %H:%M:%S")] INSTALLING curl"
echo "--------------------------------------"
PROGRAM=$(echo "$DPKG_PROGRAMS" | grep curl)
if [ "$PROGRAM" = "" ]; then
  sudo apt install curl -y
else
  echo "'curl' already installed. Ignored"
fi

echo "================================================================================"
echo "[$(date "+%Y/%m/%d %H:%M:%S")] INSTALLING sdkman"
echo "--------------------------------------"
PROGRAM=$(echo sdk v)
if [ "$PROGRAM" = "" ]; then
  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk version
  echo 'installing JAVA'
  sdk install java 8.0.252-zulu
  sdk default java 8.0.252-zulu
else
  echo "'sdkman' already installed. Ignored"
fi

echo "================================================================================"
echo "[$(date "+%Y/%m/%d %H:%M:%S")] INSTALLING git"
echo "--------------------------------------"
PROGRAM=$(echo "$DPKG_PROGRAMS" | grep python3-pip)
if [ "$PROGRAM" = "" ]; then
  sudo apt install git -y
else
  echo "'git' already installed. Ignored"
fi

echo 'Config git (y/n)?'
read config_git
if echo "$config_git" | grep -iq "^y"; then
  echo "What name do you want to use in GIT user.name? Example: Robson Policarpo"
  read git_config_user_name
  git config --global user.name "$git_config_user_name"

  echo "What email do you want to use in GIT user.email?"
  read git_config_user_email
  git config --global user.email $git_config_user_email
else
  echo "Okay :) Let's move on!"
fi

echo "================================================================================"
echo "[$(date "+%Y/%m/%d %H:%M:%S")] INSTALLING python3-pip"
echo "--------------------------------------"
PROGRAM=$(echo "$DPKG_PROGRAMS" | grep python3-pip)
if [ "$PROGRAM" = "" ]; then
  sudo apt install python3-dev python3-pip python3-setuptools
else
  echo "'python3-pip' already installed. Ignored"
fi

echo "================================================================================"
echo "[$(date "+%Y/%m/%d %H:%M:%S")] INSTALLING pycharm-community"
echo "--------------------------------------"
PROGRAM=$(echo "$SNAP_PROGRAMS" | grep pycharm)
if [ "$PROGRAM" = "" ]; then
  sudo snap install pycharm-community --classic
else
  echo "'pycharm-community' already installed. Ignored"
fi

echo "================================================================================"
echo "[$(date "+%Y/%m/%d %H:%M:%S")] INSTALLING sublime-text"
echo "--------------------------------------"
PROGRAM=$(echo "$SNAP_PROGRAMS" | grep sublime)
if [ "$PROGRAM" = "" ]; then
  sudo snap install sublime-text --classic
else
  echo "'sublime-text' already installed. Ignored"
fi

echo "================================================================================"
echo "[$(date "+%Y/%m/%d %H:%M:%S")] INSTALLING flameshot"
echo "--------------------------------------"
PROGRAM=$(echo "$DPKG_PROGRAMS" | grep flameshot)
if [ "$PROGRAM" = "" ]; then
  sudo apt install flameshot
else
  echo "'flameshot' already installed. Ignored"
fi

echo "================================================================================"
echo "[$(date "+%Y/%m/%d %H:%M:%S")] INSTALLING dbeaver-ce"
echo "--------------------------------------"
PROGRAM=$(echo "$DPKG_PROGRAMS" | grep dbeaver-ce)
if [ "$PROGRAM" = "" ]; then
  wget -c https://dbeaver.io/files/6.0.0/dbeaver-ce_6.0.0_amd64.deb
  sudo dpkg -i dbeaver-ce_6.0.0_amd64.deb
  sudo apt-get install -f
else
  echo "'dbeaver-ce' already installed. Ignored"
fi

echo "================================================================================"
echo "[$(date "+%Y/%m/%d %H:%M:%S")] INSTALLING awscli"
echo "--------------------------------------"
PROGRAM=$(echo "$DPKG_PROGRAMS" | grep awscli)
if [ "$PROGRAM" = "" ]; then
  sudo apt-get install awscli -y
  aws --version
  curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
  sudo dpkg -i session-manager-plugin.deb
  session-manager-plugin --version
else
  echo "'aws-cli' already installed. Ignored"
fi

echo "================================================================================"
echo "[$(date "+%Y/%m/%d %H:%M:%S")] INSTALLING docker-io"
echo "--------------------------------------"
PROGRAM=$(echo "$DPKG_PROGRAMS" | grep docker)
if [ "$PROGRAM" = "" ]; then
  sudo apt-get remove docker docker-engine docker.io
  sudo apt install docker.io -y
  sudo systemctl start docker
  sudo systemctl enable docker
  docker --version
  chmod 777 /var/run/docker.sock

  echo 'installing docker-compose'
  sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  docker-compose --version
else
  echo "'docker-io' already installed. Ignored"
fi

echo "================================================================================"
echo "[$(date "+%Y/%m/%d %H:%M:%S")] INSTALLING nvm"
echo "--------------------------------------"
PROGRAM=$(echo nvm --version)
if [ "$PROGRAM" = "" ]; then
  sh -c "$(curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash)"

  export NVM_DIR="$HOME/.nvm" && (
    git clone https://github.com/creationix/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    git checkout $(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1))
  ) && \. "$NVM_DIR/nvm.sh"

  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  nvm --version
  nvm install 12
  nvm alias default 12
  node --version
  npm --version
else
  echo "'nvm' already installed. Ignored"
fi
