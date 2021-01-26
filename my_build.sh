#!/bin/sh

# you may need:
# sudo apt-get install libssl-dev

./configure --enable-ssl --enable-inet6 --prefix=/usr --exec-prefix=/usr/sbin --sysconfdir=/etc

if [ -f "/etc/ssmtp/revaliases" ]; then
   if [ ! -f "/etc/ssmtp/revaliases.bak" ]; then
      sudo cp /etc/ssmtp/revaliases /etc/ssmtp/revaliases.bak
   fi
fi

make clean && make
sudo make install

if [ -f "/etc/ssmtp/revaliases.bak" ]; then
   sudo cp /etc/ssmtp/revaliases.bak /etc/ssmtp/revaliases
fi

sudo chgrp mail /etc/ssmtp/*
sudo chmod  640 /etc/ssmtp/*
sudo chmod  644 /etc/ssmtp/revaliases
sudo chgrp mail /usr/sbin/ssmtp
sudo chmod 2555 /usr/sbin/ssmtp

# For each user:
# sudo usermod -a -G mail ${userid}

# this updates the system MTA from something like exim4 to the ssmtp agent
# but this does not fix the basic configuration required in /etc/ssmtp/ssmtp.conf
sudo rm /etc/alternatives/mail
sudo ln -s /usr/sbin/ssmtp /etc/alternatives/mail

