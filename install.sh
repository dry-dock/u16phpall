#!/bin/bash -e

locale-gen en_US.UTF-8
export LANG=en_US.UTF-8

apt-get clean
mv /var/lib/apt/lists/* /tmp
mkdir -p /var/lib/apt/lists/partial
apt-get clean


# Install dependencies
echo "=========== Installing dependencies ============"
#apt-get purge `dpkg -l | grep php| awk '{print $2}' |tr "\n" " "`
add-apt-repository -y ppa:ondrej/php

apt-get update
apt-get install php5.6-dev php7.0-dev php7.1-dev
apt-get install php5.6 php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-xml

apt-get install -y git wget cmake libmcrypt-dev libreadline-dev libzmq-dev
apt-get install -y libxml2-dev     \
                libjpeg-dev     \
                libpng-dev      \
                libtidy-dev     \
                libxml2-dev     \
                libpcre3-dev    \
                libbz2-dev      \
                libcurl4-openssl-dev    \
                libminiupnpc-dev\
                libdb5.3-dev    \
                libpng12-dev    \
                libxpm-dev      \
                libfreetype6-dev        \
                libgd-dev       \
                libgmp-dev      \
                libmhash-dev    \
                unixodbc-dev    \
                freetds-dev     \
                libpspell-dev   \
                libsnmp-dev     \
                libxslt1-dev    \
                libmcrypt-dev   \
                bzip2

# Install php-build
echo "============ Installing php-build =============="
git clone git://github.com/php-build/php-build.git $HOME/php-build
$HOME/php-build/install.sh
rm -rf $HOME/php-build

#Download pickle
git clone https://github.com/FriendsOfPHP/pickle.git /tmp/pickle
ln -s /tmp/pickle/bin/pickle /usr/bin/

# Install phpenv
git clone git://github.com/CHH/phpenv.git $HOME/phpenv
$HOME/phpenv/bin/phpenv-install.sh
echo 'export PATH=$HOME/.phpenv/bin:$PATH' >> /etc/drydock/.env
echo 'eval "$(phpenv init -)"' >> /etc/drydock/.env
rm -rf $HOME/phpenv

# Activate phpenv
export PATH=$HOME/.phpenv/bin:$PATH
#echo "PATH=$HOME/.phpenv/bin:$PATH"
eval "$(phpenv init -)"

# Install librabbitmq
echo "============ Installing librabbitmq ============"
cd /tmp && wget -nv https://github.com/alanxz/rabbitmq-c/releases/download/v0.7.1/rabbitmq-c-0.7.1.tar.gz
tar xzf rabbitmq-c-0.7.1.tar.gz
mkdir build && cd build
cmake /tmp/rabbitmq-c-0.7.1
cmake -DCMAKE_INSTALL_PREFIX=/usr/local /tmp/rabbitmq-c-0.7.1
cmake --build . --target install
cd /tmp/rabbitmq-c-0.7.1
autoreconf -i
./configure
make
make install
cd /

for file in /u16phpall/version/*.sh;
do
  . $file
done

# Cleaning package lists
echo "================= Cleaning package lists ==================="
apt-get clean
apt-get autoclean
apt-get autoremove

cd /
