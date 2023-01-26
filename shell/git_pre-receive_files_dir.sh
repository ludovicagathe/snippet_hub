#!/bin/sh
#

sudo cp -R /var/www/meemdev/sites/default/files/* /home/ubuntu/meem.git/sites/default/files/
sudo chown -R /home/ubuntu/meem.git/sites/default/files/*

GITDIR=/home/ubuntu/meem.git
cd $GITDIR
unset GIT_DIR
echo "Remote files copied. Issuing commit.."
git --work-tree=$GITDIR --git-dir=$GITDIR add . -A
git --work-tree=$GITDIR --git-dir=$GITDIR commit -m 'Local changes commit'
exit 0