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
* `apache-make-site SITE_NAME USER` - создание локального сайта, дача прав к нему указанному пользователю
* `apache-delete-site SITE_NAME` - удаление локального сайта

#### Laravel
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

* GIT
```bash
sudo apt install git
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