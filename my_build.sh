./configure --enable-ssl --prefix=/usr --exec-prefix=/usr/sbin --sysconfdir=/etc

if [ -f "/etc/ssmtp/revaliases" ]; then
   if [ ! -f "/etc/ssmtp/revaliases.bak" ]; then
      sudo cp /etc/ssmtp/revaliases /etc/ssmtp/revaliases.bak
   fi
fi

make
sudo make install

sudo chgrp mail /usr/sbin/ssmtp
sudo chmod 2755 /usr/sbin/ssmtp

if [ -f "/etc/ssmtp/revaliases.bak" ]; then
   sudo cp /etc/ssmtp/revaliases.bak /etc/ssmtp/revaliases
fi

# For each user:
# sudo usermod -a -G mail ${userid}
