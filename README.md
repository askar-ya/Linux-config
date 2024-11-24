# Обновление списка пакетов
```sudo apt-get update```

# Обновление пакетов
```sudo apt-get upgrade```

# Установка полезного софта
#### Текстовый редактор, продвинутая работа по ssh, терминальный мультиплексор, менеджер процессов, git, работа с сетью, работа с zip, пакеты для компиляции. 

```
sudo apt-get install -y vim mosh tmux htop git curl wget unzip zip gcc build-essential make cmake
```
## Базовые пакеты
```
sudo apt-get install -y zsh tree zlib1g-dev libbz2-dev libreadline-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev liblzma-dev python3-dev python3-lxml libxslt-dev python3-libxml2 libffi-dev libssl-dev python3-dev gnumeric libpq-dev libxml2-dev libxslt1-dev libjpeg-dev libfreetype6-dev libcurl4-openssl-dev bison flex xsltproc ninja-build gettext libxml2-utils xsltproc docbook-xsl
```
## Oh-my-zsh
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
## Создание директорий для Софта, Кода, Игр
```
cd
mkdir Code Soft Game
mkdir Code/python
mkdir Soft/python3
mkdir Soft/psql
mkdir Soft/nvim
```

## Установка Python3.12
```
wget https://www.python.org/ftp/python/3.12.2/Python-3.12.2.tgz ; \
tar xvf Python-3.12.* ; \
cd Python-3.12.2 ; \
./configure --enable-optimizations --prefix=/home/askar/Soft/python3 ; \
make -j8 ; \
sudo make altinstall
```

## Установка Postgresql-17

### Скачивание и распаковка 
```
wget https://ftp.postgresql.org/pub/source/v17.0/postgresql-17.0.tar.gz ; \
tar xvf postgresql-17.0.tar.gz
cd postgresql*
```
### Указываем директорию для установки и собираем psql, создаем директорию для хранения данных
```
./configure --prefix=/home/askar/Soft/psql
make world
make install-world
mkdir Soft/psql/main
```
### Делаем владельцем директории нашего юзера, указываем директорию для баз данных, стартуем сервер
```
sudo chown -R askar ~/Soft/psql
cd ~/Soft/psql
./bin/pg_ctl initdb -D ~/Soft/psql/main
./bin/pg_ctl -D /home/askar/Soft/psql/main -l logfile start > out.txt
```

## Установка Neovim
#### Копируем репозиторий
```
git clone https://github.com/neovim/neovim.git
cd neovim
```
#### Указываем директорию для установки и собираем пакет
```
make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=/home/askar/Soft/nvim
make install
```
## установка node-js, npm, pyright для работы lsp и плагинов в neovim

### node-js
```
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt update
sudo apt upgrade
sudo apt install nodejs
```

### pyright
```
npm install -g pyright
```
### Создание конфига neovim, установка менеджера плагинов nvim
```
mkdir ~/.config/nvim
touch ~/.config/nvim/init.lua
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

## Установка тем для Tmux
```
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .
```
