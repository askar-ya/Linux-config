sudo apt-get update

sudo apt-get install -y vim mosh tmux htop git curl wget unzip zip gcc build-essential make cmake

sudo apt-get install -y zsh tree zlib1g-dev libbz2-dev libreadline-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev liblzma-dev python3-dev python3-lxml libxslt-dev python3-libxml2 libffi-dev libssl-dev python3-dev gnumeric libpq-dev libxml2-dev libxslt1-dev libjpeg-dev libfreetype6-dev libcurl4-openssl-dev bison flex xsltproc ninja-build gettext

cd
mkdir Code Soft Game

mkdir Code/python
mkdir Soft/python3
mkdir Soft/psql
mkdir Soft/nvim

wget https://www.python.org/ftp/python/3.12.2/Python-3.12.2.tgz ; \
tar xvf Python-3.12.* ; \
cd Python-3.12.2 ; \
./configure --enable-optimizations --prefix=/home/askar/Soft/python3 ; \
make -j8 ; \
sudo make altinstall


wget https://ftp.postgresql.org/pub/source/v17.0/postgresql-17.0.tar.gz ; \
cd postgresql*
./configure --prefix=/home/askar/Soft/psql
make world
make install-world
mkdir Soft/psql/main
sudo chown -R askar ~/Soft/psql
cd ~/Soft/psql
./bin/pg_ctl initdb -D ~/Soft/psql/main
./bin/pg_ctl -D /home/askar/Soft/psql/main -l logfile start > out.txt

git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=/home/askar/Soft/nvim
make install


cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt update
sudo apt upgrade
sudo apt install nodejs
npm install -g pyright
mkdir ~/.config/nvim
touch ~/.config/nvim/init.lua
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'







