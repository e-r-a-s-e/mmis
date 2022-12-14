#!/bin/bash
#
# This is a script that will download the dependencies and compile MakeMKV. Made this for the people on linux who don't wanna recompile a bunch of times if they use multiple machines.
#
# Made for and tested on Debian 11.
#

clear
echo "Downloading dependencies (root required)"
sleep 2

sudo apt-get install build-essential pkg-config libc6-dev libssl-dev libexpat1-dev libavcodec-dev libgl1-mesa-dev qtbase5-dev zlib1g-dev wget

if [ $? -ne 0 ]; then
    echo "Failed to download dependencies"
    exit
fi

clear
echo "Downloading MakeMKV..."
sleep 2

mkdir ~/makemkv && cd ~/makemkv

wget -c https://www.makemkv.com/download/makemkv-bin-1.17.2.tar.gz
wget -c https://www.makemkv.com/download/makemkv-oss-1.17.2.tar.gz

tar xvf makemkv-bin-1.17.2.tar.gz
tar xvf makemkv-oss-1.17.2.tar.gz

clear
echo "compiling part 1..."
sleep 2

cd makemkv-oss-1.17.2/
./configure
make

if [ $? -ne 0 ]; then
    echo "Failed to compile makemkv-oss"
    exit
fi

sudo make install

clear
echo "compiling part 2..."
sleep 2

cd ~/makemkv/makemkv-bin-1.17.2/
make

if [ $? -ne 0 ]; then
    echo "Failed to compile makemkv-bin"
    exit
fi

sudo make install

cd ~/
rm -rf ~/makemkv/

clear
echo "Download complete! You should now be able to launch MakeMKV through your applications menu or through the terminal at location /usr/bin/makemkv"