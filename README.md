# Конфигуратор оболочки ZSH
v. 0.9.11

## Дополнительные команды

#### Терминал
* `c` - очистить консоль
* `x` - выйти из терминала

#### Редакторы
* `vs` - Visual Studio Code
* `edit` - MC Edit

#### Директории
* `dir-proj` - cd ~/Project
* `dir-domain` - cd ~/Domain
* `dir-docker` - cd ~/Docker

#### Дополнительные команды
* `zconf` - конфигурация zsh
* `phpini` - редактирование php.ini /PHP 7.2/
* `linux` - информация о хосте пользователя

#### Apache сервер
* `apache-status` - статус сервера
* `apache-start` - запуск сервера
* `apache-restart` - перезагрузка сервера
* `apache-stop` - остановка сервера
* `apache-make-site SITE_NAME` - создание локального сайта, дача прав к нему указанному пользователю
* `apache-delete-site SITE_NAME` - удаление локального сайта
* `apache-error-check` - проверка синтаксических ошибок настроек сервера
* `apache-hosts` - вывести список всех виртуальных сайтов

#### Laravel
* Cоздание проекта на Laravel, с указанием версии фреймворка. Будет установлена указананя вкоманде версия фреймворка, подключен Laravel Debugbar.
  
```
laravel-create-project SITE_NAME LARAVEL_VERS
```

* `lar` - php artisan



## Плагины
* git 
* npm 
* vagrant 
* composer 
* sudo 
* web-search 
* laravel5
* docker
* colored-man-pages


## Требования
Должно быть установлено:

* curl
```bash
sudo apt install curl 
```

PHP >= 7.2

```
sudo apt install php7.2 php7.2-fpm php-pear php-pecl php7.2-cli php7.2-curl php7.2-dev libapache2-mod-php7.2 php7.2-mbstring php7.2-xml php7.2-xmlrpc php7.2-zip php7.2-mysql php7.2-imagick php7.2-gd php7.2-tidy php7.2-intl php7.2-recode

# install PHP 7.2 MCrypt
sudo apt install libmcrypt-dev libreadline-dev
pecl install mcrypt-1.0.1
# You should add "extension=mcrypt.so" to php.ini
```

* GIT
```bash
sudo apt install git
```

* Composer
```
sudo apt install composer
```

* NPM
```
sudo apt install npm
```

* MC
```
sudo apt install mc
```

* Visual Studio Code

## Установка

```bash
# Install ZSH
sudo apt-get install zsh

#Install Oh My ZSH!
# Curl
curl -L http://install.ohmyz.sh | sh
# еще вариант
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# Вариант через Wget
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
# либо
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"


# ZSH оболочко по умолчанию в терминале
chsh -s /bin/zsh
```

```bash
# Powerline 
 sudo apt install powerline
```

Устанавливаем шрифты:

```bash
# Powerline fonts
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd ..
rm -rf fonts

# or
sudo apt install fonts-powerline
```

```bash
# ZSH Powerlevel9k Theme
sudo apt install zsh-theme-powerlevel9k

echo "source /usr/share/powerlevel9k/powerlevel9k.zsh-theme" >> ~/.zshrc
```

```bash
# ZSH Syntax Highlighting
sudo apt install zsh-syntax-highlighting

echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
```

Установить шрифт `Hack Regular Nerd Font Complete.ttf` из данного репозитория.


## Удаление

```bash
# Удаляем Oh My Zsh и всё что с ним связано
uninstall_oh_my_zsh
# Удаляем Zsh
sudo apt uninstall zsh
```