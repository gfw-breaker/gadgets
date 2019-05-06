#!/bin/bash
# author: gfw-breaker
# desc: record hls video
# caution: please remove all .ts files before running this script

url="$1"
baseUrl=$(dirname $url)
m3u8=playlist.m3u8

# check if it is a multiple playlist 
wget $url -O $m3u8
def=$(cat $m3u8 | grep 'm3u8$' | sed -n '$p')
if [ "$def" != "" ]; then
	url="$baseUrl/$def"
	baseUrl=$(dirname $url)	
	wget $url -O $m3u8
fi

# check if playlist has an end
grep -i 'EXT-X-ENDLIST' $m3u8
if [ $? -eq 0 ]; then
	for frag in $(grep 'ts$' $m3u8); do
		echo "getting $frag ..."
		wget -q "$baseUrl/$frag" -O $frag
	done
	echo -e "\nall .ts files are downloaded.\n"
	exit 0
fi

# endless playlist
while : ; do
	# download m3u8 and media 
	wget -q $url -O $m3u8
	for mname in $(grep 'ts$' $m3u8); do
		frag=$mname
		if [ -f $frag ]; then
			#echo "skipping $frag ..."
			continue
		fi
		echo "getting  $frag ..."
		wget -q "$baseUrl/$mname" -O $frag 
	done
	
	# wait for 1 sec (remove the sleep if ts duration is too short)
	sleep 1	
done

