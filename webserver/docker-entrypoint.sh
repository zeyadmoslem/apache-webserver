#!/bin/sh

# # check file rights
# if [ -d /var/www/html ]
# then
#   chown -R www-data:www-data /var/www/html
# fi;

# chown www-data:www-data /var/www

# mkdir -p /var/www/.composer
# chown -R www-data:www-data /var/www/.composer


# # add ssh key
if [ ! -d /var/www/.ssh ]
then
  mkdir /var/www/.ssh
  chown www-data:www-data /var/www/.ssh
fi;

if [ -f /tmp/.ssh/id_rsa ]
then
  cp /tmp/.ssh/id_rsa /var/www/.ssh/id_rsa
  chown www-data:www-data /var/www/.ssh/id_rsa
  chmod 0700 /var/www/.ssh/id_rsa
fi;

# add known_hosts
if [ -f /tmp/.ssh/known_hosts ]
then
  cp /tmp/.ssh/known_hosts /var/www/.ssh/known_hosts
  chown www-data:www-data /var/www/.ssh/known_hosts
  chmod 0700 /var/www/.ssh/known_hosts
fi;


# add cronjob
if [ -f /tmp/crontab ]
then
  crontab -u www-data /tmp/crontab
  cron -f -L 15
fi;


# # add global git config
# touch /var/www/.gitconfig
# chown www-data:www-data /var/www/.gitconfig
# chmod 0700 /var/www/.gitconfig
# echo "[pull]
#         rebase = false" >> /var/www/.gitconfig
# git config --global pull.rebase false


exec apache2-foreground
