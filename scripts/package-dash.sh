VSRC=$1
OUTPUT_PATH=${PWD}/media/package/$(basename $VSRC)/dash

## Function to package stream file
packageStream() {
  filePath=$1
  type=$2

  filename=$(basename $filePath)
  contentId=$(echo -n filename | xxd -p)

  packager \
    input=$filePath,stream=$type,output=$OUTPUT_PATH/encrypt-$filename --output_media_info &
}

## Process video
for filePath in $VSRC*.mp4; do
  filename=$(basename $filePath)
  file=$OUTPUT_PATH/"encrypt-"$filename".media_info"

  if [ ! -f $file ]; then
    echo "File not encrypted: "$filename
    packageStream $filePath video
  fi
done

## Process audio
for filePath in $VSRC*.m4a; do
  filename=$(basename $filePath)
  file=$OUTPUT_PATH/"encrypt-"$filename".media_info"

  if [ ! -f $file ]; then
    echo "File not encrypted: "$filename
    packageStream $filePath audio
  fi
done

## Process subtitles
for filePath in $VSRC*.vtt; do
  filename=$(basename $filePath)
  file=$OUTPUT_PATH/"encrypt-"$filename".media_info"

  if [ ! -f $file ]; then
    echo "File not encrypted: "$filename
    packageStream $filePath text
  fi
done

## wait for all stream packaging to be done
wait

## Generate MPD file
for filePath in ./tmp/*.media_info; do
  if [[ -z $input ]]; then
    input=$filePath
  else
    input=$input","$filePath
  fi
done

mpd_generator \
--input $input \
--output $OUTPUT_PATH/"output.mpd"