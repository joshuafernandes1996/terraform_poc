#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

# install Node and NPM
echo "Installing Node and NPM..."
sudo apt-get update -y
# sudo apt-get update && sudo apt-get -y upgrade
# sudo apt --assume-yes install nodejs
# sudo apt --assume-yes install npm

# # Install server and db related packages
# sudo apt --assume-yes install apache2    

# #mysql-server installation with root password
# sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
# sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'
# sudo apt-get -y install mysql-server

# sudo add-apt-repository ppa:ondrej/php -y
# sudo apt --assume-yes install php7.0    
# sudo apt --assume-yes install php7.0 libapache2-mod-php7.0 php7.0-common php7.0-mbstring php7.0-xmlrpc php7.0-soap php7.0-gd php7.0-xml php7.0-intl php7.0-mysql php7.0-cli php7.0-mcrypt php7.0-zip php7.0-curl
# exit

# sudo systemctl stop apache2.service
# sudo systemctl start apache2.service
# sudo systemctl enable apache2.service  
# sudo systemctl status apache2.service	

# sudo systemctl stop mysql.service
# sudo systemctl start mysql.service
# sudo systemctl enable mysql.service  
# sudo systemctl status mysql.service	