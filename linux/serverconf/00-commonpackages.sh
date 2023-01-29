#!/bin/bash
#00-commonpackages

myuser="ludz"

sudo timedatectl set-timezone Indian/Mauritius

if [[ "$LC_ALL" != "en_US.UTF-8" ]]; then sudo echo "LC_ALL=en_US.UTF-8" >> /etc/environment;fi
if [[ "$LANG" != "en_US.UTF-8" ]]; then sudo echo "LANG=en_US.UTF-8" >> /etc/environment;fi
if [[ "$LANGUAGE" != "en_US.UTF-8" ]]; then sudo echo "LANGUAGE=en_US.UTF-8" >> /etc/environment;fi

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

#sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
#sudo add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirror.jmu.edu/pub/mariadb/repo/10.1/ubuntu xenial main'

# mongodb
# sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
# echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list

# sudo apt-get install -y mongodb-org
# sudo rm /var/lib/mongodb/mongod.lock
# sudo systemctl restart mongod

sudo apt-get update
sudo apt-get dist-upgrade -y

sudo apt-get install -y software-properties-common build-essential

sudo apt-get install -y php7.0 php7.0-cgi php7.0-cli php7.0-common php7.0-curl php7.0-dev php7.0-fpm php7.0-gd php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-xml php7.0-json php7.0-opcache php7.0-xmlrpc php-pear php-geoip libgeoip-dev geoip-bin geoip-database nodejs git-core libssh2-1-dev libssh2-1 python-dev libpython-dev python-pip awscli

cd /home/$myuser
sudo -u $myuser mkdir php_ssh2
cd php_ssh2
sudo -u $myuser wget https://github.com/Sean-Der/pecl-networking-ssh2/archive/php7.zip
sudo -u $myuser unzip php7.zip
cd pecl-networking-ssh2-php7
sudo -u $myuser phpize
sudo -u $myuser ./configure
sudo make
sudo make install


cd /home/$myuser
if [[ ! -d composer ]]; then sudo -u $myuser mkdir composer; fi
cd composer
sudo -u $myuser curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

cd /usr/local/bin
if [[ ! -d drush-8 ]]; then sudo mkdir drush-8; fi
cd drush-8
sudo composer require drush/drush:8.x
sudo ln -s /usr/local/bin/drush-8/vendor/bin/drush /usr/local/bin/drush8

cd /usr/local/bin
if [[ ! -d drush-7 ]]; then sudo mkdir drush-7; fi
cd drush-7
sudo composer require drush/drush:7.x
sudo ln -s /usr/local/bin/drush-7/vendor/bin/drush /usr/local/bin/drush7

sudo touch /home/$myuser/drushtmp
echo "$(cat <<FILE
#!/bin/bash
version=$(git config --get drush.version)
if [ "\$version" = '8' ];
then
drush8 "\$@"
else
drush7 "\$@"
fi
FILE
)" | sudo tee --append /home/$myuser/drushtmp >/dev/null
sudo chmod +x /home/$myuser/drushtmp
sudo mv /home/$myuser/drushtmp /usr/local/bin/drush

sudo touch /home/$myuser/drushtmp
echo "$(cat <<FILE
#!/bin/bash
sudo -u www-data drush "\$@"
FILE
)" | sudo tee --append /home/$myuser/drushtmp >/dev/null
sudo chmod +x /home/$myuser/drushtmp
sudo mv /home/$myuser/drushtmp /usr/local/bin/drushw

sudo touch /home/$myuser/drushtmp
echo "$(cat <<FILE
#!/bin/bash
sudo -u www-data "\$@"
FILE
)" | sudo tee --append /home/$myuser/drushtmp >/dev/null
sudo chmod +x /home/$myuser/drushtmp
sudo mv /home/$myuser/drushtmp /usr/local/bin/sudow


sudo chown -R $myuser:$myuser /home/$myuser/.composer
cd /home/$myuser/composer
composer require twig/twig:~2.0

sudo -u $myuser mkdir /home/$myuser/.npm-global
sudo -u $myuser npm config set prefix "/home/$myuser/.npm-global"
echo "export PATH=~/.npm-global/bin:\$PATH" >> /home/$myuser/.profile
source /home/$myuser/.profile
npm install -g npm david grunt pm2 bower hapi restify request gm

cd /home/$myuser
sudo -u $myuser mkdir aws
cd aws

sudo apt-get install -y mysql-server
#mysqld_safe --skip-grant-tables
mysql_secure_installation

sudo apt-get install -y apache2 apache2-bin apache2-data apache2-utils libapache2-mod-php libapache2-mod-php7.0 redis-server

# Redis support
sudo pecl install redis
sudo touch /etc/php/7.0/apache2/conf.d/30-redis.ini
echo "$(cat <<FILE
extension=redis.so
FILE
)" | sudo tee --append /etc/php/7.0/apache2/conf.d/30-redis.ini >/dev/null

sudo systemctl disable php7.0-fpm
#echo "manual" | sudo tee /etc/init/php7.0-fpm.override >/dev/null

sudo chown -R $myuser:$myuser /home/$myuser

#APACHE CONFIG

APA_FOLDER="/etc/apache2"

cd $APA_FOLDER
if [[ ! -d bkp ]]; then sudo mkdir bkp;fi

if [[ -d ${APA_FOLDER}/mods-enabled ]]; then sudo mv ${APA_FOLDER}/mods-enabled ${APA_FOLDER}/mods-enabled-bkp;fi

if [[ -f ${APA_FOLDER}/apache2.conf ]]; then sudo mv ${APA_FOLDER}/apache2.conf ${APA_FOLDER}/apache2.`date +"%Y%m%d%H%M%S"`.conf.bkp;fi
sudo mv ./*.conf ./bkp
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
)" | sudo tee --append ${APA_FOLDER}/apache2.conf

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
  "php7.0"
)

for i in ${APA_MODS[@]}; do
  [[ -f ${APA_FOLDER}/mods-available/${i}.load ]] && sudo cat ${APA_FOLDER}/mods-available/${i}.load | sudo tee --append ${APA_FOLDER}/apache2.conf >/dev/null
done

for i in ${APA_MODS[@]}; do
  [[ -f ${APA_FOLDER}/mods-available/${i}.conf ]] && sudo cat ${APA_FOLDER}/mods-available/${i}.conf | sudo tee --append ${APA_FOLDER}/apache2.conf >/dev/null
done

echo "$(cat <<FILE
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
        DocumentRoot /var/www/html/default

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
)"  | sudo tee --append ${APA_FOLDER}/apache2.conf >/dev/null

ls -alh ${APA_FOLDER}


## DRUPAL ##

sudo chown -R www-data:www-data /var/www/html && sudo chmod -R 755 /var/www/html
cd /var/www/html
drushw dl drupal --drupal-project-rename=app1
cd app1
drushw dl admin_menu module_filter bootstrap_carousel_if bootstrap_login_modal bootstrap_quicktabs bootstrap_tour bootstrap_ux ajaxblocks ctools google_chart_tools charts commerce commerce_add_to_cart_extras commerce_addressbook commerce_cart_expiration commerce_currency_settings commerce_discount commerce_discount_fields commerce_extra_price_formatters commerce_free_shipping commerce_fieldgroup_panes commerce_price_decimals_formatter commerce_wishlist commerce_paypal commerce_paypal_ec commerce_reports commerce_flat_rate commerce_shipping commerce_stock context date devel ds_bootstrap_layouts elasticsearch_connector entityconnect simple_fb_connect addressfield blockreference bootstrap_fieldgroup bundle_copy ddf entityreference field_collection field_conditional_state field_formatter_class field_group field_permissions filefield_sources inline_entity_form multiple_selects multiupload_filefield_widget multiupload_imagefield_widget range references sliderfield title viewfield youtube flexslider improved_multi_select icon imagecache_token manualcrop jquery_ajax_load mailsystem mimemail bootstrap_carousel dragndrop_upload epsacrop file_entity imce imce_filefield imce_mkdir media media_vimeo media_youtube menu_editor tb_megamenu entity_translation i18n i18nviews simple_subscription node_display_fields addtoany auto_nodetitle backup_migrate batch_add_terms better_formats block_class colorbox composer_manager css_injector disable_taxonomy_description entity entity_view_mode exclude_node_title fieldblock field_collection_table field_collection_views field_formatter_settings focal_point fontawesome hires_images htmLawed imagefield_crop image_dimensions image_url_formatter insert js_injector less libraries logintoboggan menu_attributes menu_token multiblock nivo_slider pathauto quicktabs redirect tabname_tweaker tabtamer timeago token transliteration unique_field webform_button_classes xautoload owlcarousel redis expire purge respondjs inline_conditions rules search_api search_api_autocomplete apachesolr_autocomplete apachesolr facetapi select_with_style metatag metatag_panels captcha hidden_captcha recaptcha taxonomy_access_fix taxonomy_menu commentsblock bootstrap_library twitter_bootstrap_modal bootstrap_modal_messages ckeditor ckeditor_insert ckeditor_link ckeditor_plain_summary imce_wysiwyg jquery_update responsive_menus wysiwyg uuid variable better_exposed_filters editableviews eva node_reference_view_formatter views views_bootstrap views_content_cache views_date_format_sql views_distinct views_nivo_slider views_php views_slideshow views_slideshow_galleria views_slideshow_jcarousel views_slideshow_jcarouselthumbs fivestar halfstar plus1 rate votingapi webform webform_bt_layout webform_localization bootstrap

sudo systemctl stop apache2 && sudo systemctl start apache2

sudo apt-get install -y nginx nginx-extras postfix

# Service check
echo ""
echo "=========================="
echo -e "php: \n$(php -v)\n"
echo -e "node: \n$(node -v)\n"
echo -e "npm: \n$(npm -v)\n"
echo -e "composer: \n$(composer --version)\n"
echo -e "drush: \n$(drush -v)\n"
echo -e "pip: \n$(pip --version)\n"
echo -e "aws: \n$(aws --version)\n"
echo -e "mysql: \n$(mysql --version)\n"
echo -e "apache2: \n$(apache2 -v)\n"
echo -e "apache2: \n$(curl -I http://localhost:8080)\n"
echo -e "nginx: \n$(nginx -v)\n"
echo -e "nginx: \n$(curl -I http://localhost)\n"
echo "=========================="

#sudo reboot
echo ""
echo "Package installation complete"
echo "Consider rebooting before proceeding with next script"
echo "Create database and set up user for drupal installation"
