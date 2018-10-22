#!/bin/sh

echo "Ubuntu Update"
sleep 5s

apt-get update -y

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
echo "Install mysql-server done"
