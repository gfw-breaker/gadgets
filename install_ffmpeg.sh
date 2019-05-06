#!/bin/bash

wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar -xvzf yasm-1.3.0.tar.gz
cd yasm-1.3.0/
./configure
make && make install


wget https://ffmpeg.org/releases/ffmpeg-4.1.tar.bz2
tar -xjvf ffmpeg-4.1.tar.bz2
cd ffmpeg-4.1
./configure --prefix=/usr/local/ffmpeg
make && make install

