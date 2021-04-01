#ssl
mkdir etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key -subj "/C=FR/ST=Lyon/L=Lyon/O=42 LYON/OU=yfu/CN=localhost"


#nginx
mv ./default etc/nginx/sites-available/
rm -rf var/www/*
#chown -R www-data var/www/*
#chmod -R 755 /var/www/*

#mysql
service mysql start
echo "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'wordpress_user'@'localhost' IDENTIFIED BY 'password';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

#phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv phpMyAdmin-4.9.0.1-all-languages var/www/phpmyadmin
mv ./config.inc.php var/www/phpmyadmin #check the conf
chmod 660 /var/www/phpmyadmin/config.inc.php
chown -R www-data:www-data /var/www/phpmyadmin
service php7.3-fpm start
echo "GRANT ALL ON *.* TO 'yfu'@'localhost' IDENTIFIED BY '123'" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

#wordpress
wget https://wordpress.org/latest.tar.gz
tar xvf latest.tar.gz
mkdir var/www/wordpress
cp -a wordpress/. /var/www/wordpress
mv ./wp-config.php /var/www/wordpress

service nginx start
sleep infinity
