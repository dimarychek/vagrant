#!/usr/bin/env bash

sudo apt-get update

# nginx
sudo apt-get -y install nginx
sudo service nginx start

sudo cp /vagrant/.provision/nginx/nginx.conf /etc/nginx/sites-available/site.conf
sudo chmod 644 /etc/nginx/sites-available/site.conf
sudo ln -s /etc/nginx/sites-available/site.conf /etc/nginx/sites-enabled/site.conf
sudo service nginx restart

# base packages
sudo apt-get install -y vim curl python-software-properties

# php
sudo add-apt-repository ppa:ondrej/php
sudo apt-key update
sudo apt-get update
sudo apt-get -y install php5.6 php5.6-fpm php5.6-mcrypt php5.6-mbstring php5.6-curl php5.6-cli php5.6-mysql php5.6-gd php5.6-intl php5.6-xsl php5.6-zip

# mysql
debconf-set-selections <<< "mysql-server mysql-server/root_password password secret"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password secret"
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password secret"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password secret"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password secret"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"
sudo apt-get update
sudo apt-get install -y mysql-server phpmyadmin
cp -r /usr/share/phpmyadmin/ /vagrant/


# composer
sudo curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# node.js and npm
sudo curl -sL https://deb.nodesource.com/setup_8.x | sudo sh
sudo apt-get install -y nodejs
sudo apt-get install -y npm

# install git
sudo apt-get install git

# clean /var/www
sudo rm -Rf /var/www

# symlink /var/www => /vagrant
ln -s /vagrant /var/www