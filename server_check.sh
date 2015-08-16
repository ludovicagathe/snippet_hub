#!/bin/bash
#UP=$(pgrep mysql | wc -l);
#MSG=$(sudo service mysql status);
NOW=$(date +"%Y-%m-%d @ %T");
CC=0;
ERRORS=0;
MYSQL_MSG='MySQL : OK';
REDIS_MSG='REDIS : OK';
PHP_MSG='PHP : OK';
A2_MSG='APACHE : OK';
CC_MSG='CACHES CLEARED';
MYSQLUP=$(sudo service mysql status | grep 'mysql start/running' | wc -l);
if [ "$MYSQLUP" != 1 ];
then
        CC=1;
        ERRORS=1;
        MYSQL_MSG='!!!ERROR!!! MySQL is down.';
        sudo service mysql start;
#else
#        echo "MySQL is OK.";
fi
#echo "$MSG";
REDISUP=$(sudo service redis-server status | grep 'redis-server is running' | wc -l);
if [ "$REDISUP" != 1 ];
then
        CC=1;
        ERRORS=1;
        REDIS_MSG='!!!ERROR!!! Redis is down.';
        sudo service redis-server start;
#else
#        echo "Redis is OK.";
fi
PHPUP=$(sudo service php5-fpm status | grep 'php5-fpm start/running' | wc -l);
if [ "$PHPUP" != 1 ];
then
        CC=1;
        ERRORS=1;
        PHP_MSG='!!!ERROR!!! PHP is down.';
        sudo service php5-fpm start
#else
#        echo "PHP is OK.";
fi
A2UP=$(sudo service apache2 status | grep 'apache2 is running' | wc -l);
if [ "$A2UP" != 1 ];
then
        CC=1;
        ERRORS=1;
        A2_MSG='!!!ERROR!!! Apache is down.';
        sudo service apache2 start;
#else
#        echo "Apache is OK.";
fi

if [ "$CC" != 0 ]; then
        sync; echo 3 > /proc/sys/vm/drop_caches;
        echo $NOW' => '$MYSQL_MSG'; '$REDIS_MSG'; '$PHP_MSG'; '$A2_MSG'; '$CC_MSG$'  ---END---  \n\n';
fi