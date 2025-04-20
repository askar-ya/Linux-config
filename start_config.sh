#!/bin/bash

Green='\033[0;32m'
echo "${Green}Привет, $USERNAME! Начинаю настройку"

# обновляем пакеты
echo "${Green}Обновляю пакеты."
sudo apt-get update > log.txt
sudo apt-get upgrade > log.txt

# установка пакетов
echo "Устанавливаем пакеты"
# Бaзовые пакеты
sudo apt-get install -y zlib1g-dev libbz2-dev libreadline-dev \
    llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev liblzma-dev \
    python3-dev python3-lxml libxslt-dev python3-libxml2 libffi-dev \
    libssl-dev python3-dev gnumeric libpq-dev libxml2-dev libxslt1-dev \
    libjpeg-dev libfreetype6-dev libcurl4-openssl-dev bison flex xsltproc \
    ninja-build gettext libxml2-utils xsltproc docbook-xsl libsystemd-dev > log.txt

# Полезный софт
sudo apt-get install -y zsh bat vim tmux htop git curl \
    wget unzip zip gcc build-essential make cmake > log.txt

rm log.txt
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "${Green} Установка темы tmux"
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .
cp Linux-config/tmux.conf .tmux/.tmux.conf


#Создание директорий для Софта, Кода, Игр
choo "${Green}Cоздаем папки"
cd
mkdir code soft game
mkdir code/python


install_python() {
    echo "${Green}Установка python3.12"
    cd
    wget https://www.python.org/ftp/python/3.12.2/Python-3.12.2.tgz
    tar xvf Python-3.12.*
    rm Python-3.12.2.tgz
    cd Python-3.12.2
    mkdir /home/$USERNAME/soft/python3
    ./configure --enable-optimizations --prefix=/home/$USERNAME/soft/python3 
    make -j8
    sudo make altinstall
    cd ..
    rm -fr Python-3.12.2
}

install_psql() {
    echo "${Green}Установка Postgresql"
    wget https://ftp.postgresql.org/pub/source/v17.0/postgresql-17.0.tar.gz
    tar xvf postgresql-17.0.tar.gz
    rm -fr postgresql-17.0.tar.gz
    cd postgresql*
    mkdir /home/$USERNAME/soft/psql
    ./configure --prefix=/home/$USERNAME/soft/psql --with-systemd
    make world
    make install-world
    cd ..
    rm -fr postgresql*
    mkdir /home/$USERNAME/soft/psql/main
    sudo chown -R $USERNAME ~/soft/psql
    cd ~/soft/psql
    ./bin/pg_ctl initdb -D ~/soft/psql/main
    cp ~/Linux-config/psql.service /etc/systemd/system/postgresql.service
    systemctl daemon-reload
    systemctl enable postgresql.service
    systemctl start postgresql.service
    cd
}

install_nvim() {
    echo "${Green}Установка nvim"
    cd
    git clone https://github.com/neovim/neovim.git
    mkdir /home/$USERNAME/soft/nvim
    cd neovim
    make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=/home/$USERNAME/soft/nvim
    make install
    cd ..
    rm -fr neovim
    curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt update
    sudo apt install nodejs
    npm install -g pyright
    mkdir ~/.config/nvim
    cp Linux-config/init.lua ~/.config/nvim/init.lua
    mkdir -p ~/.local/share/nvim/site/pack/packer/start/
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    echo "Выролните #nvim :PackerSync"
    echo "Затем: cd ~/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim"
    echo "make"
}

echo "${Green}Установка пакетов для разработки"
PS3="${Green}Kакие пакетыы установить: "
select opt in "All" "Python" "Psql" "Nvim" "nothing"
do
    case $opt in
        "All")
            install_python
            install_psql
            install_nvim
            break
            ;;
        "Python")
           install_python
           break
           ;;
        "Psql")
           install_psql
           break
           ;;
        "Nvim")
            install_nvim
            break
            ;;
        "nothing")
           echo "Ничего не установлено!"
           break;;
        *)
           echo "ой!";;
    esac
done


echo "${Green}Добавляю конфиг zsh"
cp ~/Linux-config/zsh.conf ~/.zshrc
. ./.zshrc

echo "${Green}ВПН:"
PS3="${Green}Установить Hiddify?: "
select opt in "yes" "no"
do
    case $opt in
        "yes")
            cd ~/soft
            mkdir vpn
            cd vpn
            https://github.com/hiddify/hiddify-app/releases/latest/download/Hiddify-Linux-x64.AppImage
            cp hiddify/* .
            break
            ;;
        "no")
           break;;
        *)
           echo "ой!";;
    esac
done


echo "${Green}Настройка завершина!"

