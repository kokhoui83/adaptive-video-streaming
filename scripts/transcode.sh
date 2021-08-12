#!/bin/bash
VSRC=$1
FILENAME=$(basename $VSRC)
NAME=$(echo $FILENAME | cut -f 1 -d '.')

if [ ! -d ./media/output/${NAME} ]; then
    mkdir -p ./media/output/${NAME}
fi;

#ffmpeg -i $VSRC -codec:v libx264 -profile:v high -preset slow -b:v 500k -maxrate 500k -bufsize 1000k -vf scale=-1:480 -threads 0 -codec:a libfdk_aac -b:a 128k output_file.mp4
ffmpeg -i $VSRC -vf scale=-2:720 ./media/output/${NAME}/${NAME}_720p.mp4 &
ffmpeg -i $VSRC -vf scale=-2:480 ./media/output/${NAME}/${NAME}_480p.mp4 &
ffmpeg -i $VSRC -vf scale=-2:360 ./media/output/${NAME}/${NAME}_360p.mp4 &
ffmpeg -i $VSRC -vf scale=-2:240 ./media/output/${NAME}/${NAME}_240p.mp4 &
wait