#!/bin/bash
#install zeromq 4.1.2

set -e

yum install -y mercurial autoconf automake libtool gcc-c++

TMPDIR=`mktemp -d`
cd $TMPDIR

curl -L http://download.wolfogre.com/zeromq/zeromq-4.1.2.tar.gz -o zeromq-4.1.2.tar.gz

tar xvzf zeromq-4.1.2.tar.gz

cd zeromq-4.1.2

./configure --without-libsodium
make
make install

cd /etc/ld.so.conf.d
echo "/usr/local/lib" >> /etc/ld.so.conf.d/usr_local_lib.conf

echo '''
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export LD_LIBRARY_PATH=/usr/local/lib
''' >> /etc/profile

source /etc/profile
ldconfig

rm -rf $TMPDIR

echo -e "\n\nOK! please run 'source /etc/profile' manually\n"
