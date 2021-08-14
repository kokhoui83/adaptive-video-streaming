VSRC=$1
OUTPUT_PATH=${PWD}/media/package/$(basename $VSRC)/hls

INPUT=""

## Process audio
for filePath in $VSRC/*.m4a; do
  filename=$(basename $filePath)
  name=$(echo $filename | cut -f 1 -d '.')
  file=$OUTPUT_PATH/"package-"$name"-audio.m3u8"

  INPUT="$INPUT in=$filePath,stream=audio,output=$OUTPUT_PATH/package-$filename,playlist_name=$file,hls_group_id=audio,hls_name=ENGLISH"
done

## Process video
for filePath in $VSRC/*.mp4; do
  filename=$(basename $filePath)
  name=$(echo $filename | cut -f 1 -d '.')
  file=$OUTPUT_PATH/"package-"$name".m3u8"

  INPUT="$INPUT in=$filePath,stream=video,output=$OUTPUT_PATH/package-$filename,playlist_name=$file"
done

packager \
  $INPUT \
--hls_master_playlist_output $OUTPUT_PATH/"master.m3u8"
