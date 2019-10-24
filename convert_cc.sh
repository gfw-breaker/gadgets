## Download youtube video and generate subtitle

if [ $# -ne 2 ]; then
	echo "Please enter the video id and file name. "
	echo "  Usage: bash convert_cc.sh _QXChEgyGD4 falsefire"
	exit 1
fi

vid=$1
fname=$2

youtube-dl -f 18 --restrict-filenames $vid

if [ $? -ne 0 ]; then
	echo "Failed to download video from YouTube, please check whether the video ID is correct..."
	exit 2
fi

mv *-$vid.mp4 $fname.mp4

autosub -F srt -S zh-CN -D zh-CN $fname.mp4

