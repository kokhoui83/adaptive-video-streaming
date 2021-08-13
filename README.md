# Adaptive Video Streaming

# Prequisites
- linux OS
- ffmpeg 4.2.x
```
sudo apt install ffmpeg
```
- shaka-packager
    - binary
```
# download
wget https://github.com/google/shaka-packager/releases/download/v2.5.1/packager-linux
wget https://github.com/google/shaka-packager/releases/download/v2.5.1/mpd_generator-linux

# move to bin
sudo mv packager-linux /usr/local/bin/packager
sudo mv mpd_generator-linux /usr/local/bin/mpd_generator
```
- nginx
```
docker pull nginx:1.21.1
```

# Video Source
## Download
- Big Buck Bunny
    - https://cloud.blender.org/films/big-buck-bunny/?asset=263
- Sintel
    - https://cloud.blender.org/films/sintel/?asset=1191
- Tears of Steel
    - https://cloud.blender.org/films/tears-of-steel/?asset=42

** Download original video and put in `./media/source`

## Prepare source file
- Source file should contain only the video stream and audio stream as separate file
- Use `shaka-packager` to transmux the original video file to separate video and audio stream
- Example
```
# transmux original video to video.mp4 and audio.m4a
packager in=big-buck-bunny.mp4,stream=video,out=video.mp4 in=big-buck-bunny.mp4,stream=audio,out=audio.m4a

# remove original video
rm big-bug-bunny.mp4

# rename audio file
mv audio.m4a big-buck-bunny.m4a

# rename video file
mv video.mp4 big-buck-bunny.mp4
```

# Scripts
## Transcode video to multi bitrate
- Video file will be retranscode to the following bitrate
    - 720p
    - 480p
    - 360p
    - 240p

- Command
```
# Example
./scripts/transcode.sh ./media/video/big-buck-bunny.mp4
```
- Transcoded file are stored in `./media/output`

## Package video as adaptive bitrate
### DASH-MPEG
- Command
```
# Example
./scripts/package-dash.sh ./media/output/big-buck-bunny
```
- Generate file will be in `./media/package/<title>/dash`

### HLS
TBA

## Run file server
```
docker run --name video-server -v ${PWD}/media/package:/usr/share/nginx/html:ro -d -p 8080:80 nginx:1.21.1
```