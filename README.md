# Adaptive Video Streaming

# Prequisites
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

# Video Source
- Big Buck Bunny
    - https://cloud.blender.org/films/big-buck-bunny/?asset=263
- Sintel
    - https://cloud.blender.org/films/sintel/?asset=1191
- Tears of Steel
    - https://cloud.blender.org/films/tears-of-steel/?asset=42

** Download original video and put in `./media/video`

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

## Run file server
```
docker run --name video-server -v ${PWD}/media/package:/usr/share/nginx/html:ro -d -p 8080:80 nginx
```