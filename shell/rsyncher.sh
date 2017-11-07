#!/bin/bash
rsync -urv --delete /var/www/html/. /home/ubuntu/backup
cd /home/ubuntu/backup
curl -s http://<DOMAIN>/cron.php?cron_key=0y6aPPFOB3BoXb8wfwqKBhxo1GLvlH8z9$
curl -s http://<DOMAIN>/ >/dev/null 2>&1
curl -s http://<DOMAIN>/node/[1-50] >/dev/null 2>&1
mysqldump -u<USER> -p<PASSWD> <DB>| gzip > <DB>.sql.gz
sudo chown -R ubuntu:ubuntu ./
git init
git add -A
git commit -am "Prod Sync"
