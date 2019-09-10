# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/orey/.oh-my-zsh"

# Директория по умолчанию
cd ~/Project

### Theme ###
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="nerdfont-complete"
#POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="▶ "
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""

ENABLE_CORRECTION="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

### Plugins ###
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
    git 
    npm 
    vagrant 
    composer 
    sudo 
    web-search 
    laravel5
    docker
    colored-man-pages
)

source $ZSH/oh-my-zsh.sh

### Alias ###
# BASH
alias c='clear'
alias x='exit'
# Visual Code
alias vs='/snap/bin/code'
# MC Edit
alias edit='mcedit'
# ZSH Config
alias zconf="vs ~/.zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh"
# OS param
alias linux='screenfetch'
# Dir
alias dir-proj='cd ~/Project'
alias dir-domain='cd ~/Domain'
alias dir-docker='cd ~/Docker'
# PHP
alias phpini='sudo vs /etc/php/7.2/cli/php.ini'

### Apache alias ###
# Управление сервером
alias apache-status='sudo service apache2 status'
alias apache-start='sudo service apache2 start'
alias apache-restart='sudo service apache2 restart'
alias apache-stop='sudo service apache2 stop'
# Директория с конфигуратором сайтов
alias apache-sites-conf-dir='cd /etc/apache2/sites-enabled/'
# Создаем новую директорию для сайта
apache-make-site() {

    if [ -d /var/www/"$1".local ]; then
        echo "\x1b[1;31mСайт $1.local уже существует, выберите другое имя\n\x1b[0m"
        curl -Is http://"$1".local
    else 
        # Создаем новую директорию для сайта
        sudo mkdir -p "/var/www/$1.local/public"
        # Копируем тестовую стартовую страницу index.php
        sudo cp /var/www/index.php "/var/www/$1.local/public/"
        # Создаем новый кофигурационный файл
        sudo touch "/etc/apache2/sites-available/$1.local.conf"
        # Конфигурация
        if [ ! -d ~/.custom_domain/_site_config ]; then
            mkdir -p ~/.custom_domain/_site_config
        fi
        touch ~/.custom_domain/_site_config/"$1".local.conf
        echo "<VirtualHost *:80>
    ServerAdmin admin@$1.local
    ServerName $1.local
    ServerAlias www.$1.local
    DocumentRoot /var/www/$1.local/public
    ErrorLog \${APACHE_LOG_DIR}/$1.error.log
    CustomLog \${APACHE_LOG_DIR}/$1.access.log combined
</VirtualHost>
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet" > ~/.custom_domain/_site_config/"$1".local.conf
        sudo cp ~/.custom_domain/_site_config/"$1".local.conf /etc/apache2/sites-available/"$1".local.conf
        # Подключаем сайт в Apache
        sudo a2ensite "$1.local.conf"
        # Добавляем хост
        sudo sed -i "$ a 127.0.1.1	$1.local" "/etc/hosts" 
        # Перезагружаем Apache
        sudo service apache2 restart
        echo -e "\n"
        curl -Is http://"$1".local
    fi
}
# Удаляем сайт
apache-delete-site() {
    if [ -d /var/www/"$1".local ]; then
        # Удаляем диреткорию с сайтом
        sudo rm -rf "/var/www/$1.local"
        # Удаляем конфигурационный файл сайта
        sudo rm "/etc/apache2/sites-available/$1.local.conf"
        # Отключаем сайт от сервера
        sudo a2dissite "$1.local.conf"
        # Убираем адресс сайта из хоста
        sudo sed -i "/127.0.1.1	$1.local/d" "/etc/hosts"
        # Перезагружаем Apache
        sudo service apache2 restart
        echo -e "\x1b[1;42mСайт удален. Сервер перезагружен\x1b[0m\n"
    else
        echo "\x1b[1;31mСайт $1.local НЕ существует, проверте имя\n\x1b[0m"
    fi
    
}

# Laravel
alias lar='php artisan' 

# Обновляем конфигурацию ZSH в репозитории
gitzsh() {
    cp ~/.zshrc ~/Project/_zsh/.zshrc
    cd ~/Project/_zsh
    git add .
    git commit -m "$1"
    git push -u origin master 
}

# Sources
source /home/orey/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh