#!/bin/bash

echo "Ubuntu Update"
sleep 5s

apt-get update -y
apt-get install wget dialog debconf sudo -y

echo "Ubuntu Update done"

sleep 5s

echo "Install apache2" 
apt-get install apache2 -y
echo " Apache2 installation is done"
sleep 5s


echo "Install php"
apt install php-pear php-fpm php-dev php-zip php-curl php-xmlrpc php-gd php-mysql php-mbstring php-xml libapache2-mod-php -y
echo " Install php done"

sleep 5s

echo "Restart apache2"
service apache2 restart
echo " Restart done"

sleep 5s

echo " Check apache2 status"
service apache2 status
sleep 10s



php -r 'echo "\n\nYour PHP installation is working fine.\n\n\n";'

sleep 5s

echo " Install mysql server"
echo "mysql-server-5.7 mysql-server/root_password password root" | sudo debconf-set-selections
echo "mysql-server-5.7 mysql-server/root_password_again password root" | sudo debconf-set-selections
apt-get -y install mysql-server-5.7
apt-get -y install mysql-server-5.7
echo "Install mysql-server done"


echo "Extract drupal"
wget https://ftp.drupal.org/files/projects/drupal-8.3.7.tar.gz
echo "Extract done"

echo "Extracting the tar file and placing it in /var/www/html/drupal"
mkdir /var/www/html/drupal
chmod 777 -R /var/www/html/drupal/
tar -pxvf drupal-8.3.7.tar.gz -C /var/www/html/drupal --strip-components=1

sleep 5s

echo " Copy the settings.php"
cp /var/www/html/drupal/sites/default/default.settings.php /var/www/html/drupal/sites/default/settings.php


sleep 2s

echo " Create directory for drupal files and give permissions"
mkdir /var/www/html/drupal/sites/default/files
chmod 777 -R /var/www/html/drupal/
sleep 5s

echo " Drupal Setup is ready"

