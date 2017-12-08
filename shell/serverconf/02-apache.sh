#!/bin/bash
#01-apache

APA_FOLDER="/etc/apache2"

cd $APA_FOLDER
if [[ ! -d bkp ]]; then sudo mkdir bkp;fi
sudo mv ./*.conf ./bkp

if [[ -d ${APA_FOLDER}/mods-enabled ]]; then sudo mv ${APA_FOLDER}/mods-enabled ${APA_FOLDER}/mods-enabled-bkp;fi

if [[ -f ${APA_FOLDER}/apache2.conf ]]; then sudo mv ${APA_FOLDER}/apache2.conf ${APA_FOLDER}/apache2.`date +"%Y%m%d%H%M%S"`.conf.bkp;fi
sudo touch ${APA_FOLDER}/apache2.conf
sudo echo "$(cat <<FILE
ServerRoot "/etc/apache2"
Mutex file:\${APACHE_LOCK_DIR} default
PidFile \${APACHE_PID_FILE}
Timeout 90
KeepAlive On
MaxKeepAliveRequests 100
KeepAliveTimeout 5
User \${APACHE_RUN_USER}
Group \${APACHE_RUN_GROUP}
HostnameLookups Off
ErrorLog \${APACHE_LOG_DIR}/error.log
LogLevel warn
AddDefaultCharset UTF-8
ServerName localhost
DirectoryIndex index.php index.html

#mods
#
FILE
)" >> ${APA_FOLDER}/apache2.conf

APA_MODS=(
  "alias"
  "authz_core"
  "authz_host"
  "filter"
  "deflate"
  "dir"
  "expires"
  "headers"
  "mime"
  "rewrite"
  "autoindex"
  "negotiation"
  "setenvif"
  "mpm_prefork"
  "actions"
  "vhost_alias"
)

for i in ${APA_MODS[@]}; do
  [[ -f ${APA_FOLDER}/mods-available/${i}.load ]] && sudo cat ${APA_FOLDER}/mods-available/${i}.load >> ${APA_FOLDER}/apache2.conf
done

for i in ${APA_MODS[@]}; do
  [[ -f ${APA_FOLDER}/mods-available/${i}.conf ]] && sudo cat ${APA_FOLDER}/mods-available/${i}.conf >> ${APA_FOLDER}/apache2.conf
done

sudo echo "$(cat <<FILE
#
#

Listen 8080

<Directory />
	Options FollowSymLinks
	AllowOverride None
	Require all denied
</Directory>

<Directory /usr/share>
	AllowOverride None
	Require all granted
</Directory>

<Directory /var/www/html>
	Options Indexes FollowSymLinks
	AllowOverride All
	Require all granted
</Directory>

AccessFileName .htaccess
<FilesMatch "^\.ht">
	Require all denied
</FilesMatch>

LogFormat "%v:%p %h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" vhost_combined
LogFormat "%h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" combined
LogFormat "%h %l %u %t \"%r\" %>s %O" common
LogFormat "%{Referer}i -> %U" referer
LogFormat "%{User-agent}i" agent

#extra conf
ServerTokens Prod
ServerSignature Off
TraceEnable Off

<VirtualHost *:8080>
        ServerName localhost

        ServerAdmin ludovic.agathe@gmail.com
        DocumentRoot /var/www/html

        DirectoryIndex index.php index.html

        LogLevel warn

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

<VirtualHost *:8080>
        ServerName app1.localhost

        ServerAdmin ludovic.agathe@gmail.com
        DocumentRoot /var/www/html/app1

        DirectoryIndex index.php index.html

        LogLevel warn

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>


#
FILE
)" >> ${APA_FOLDER}/apache2.conf

ls -alh ${APA_FOLDER}
#source /etc/apache2/envvars
sudo mkdir -p /var/www/html/app1

sudo apache2ctl stop && sudo apache2ctl start
