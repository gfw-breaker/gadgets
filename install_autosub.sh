# Install youtube-dl and autosub

apt install -y python python-pip ffmpeg

pip install setuptools 

pip install autosub

wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/bin/youtube-dl
chmod a+rx /usr/bin/youtube-dl

wget https://raw.githubusercontent.com/gfw-breaker/gadgets/master/convert_cc.sh -O convert_cc.sh

