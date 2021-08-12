# Adaptive Video Streaming

# Prequisites
- ffmpeg 4.2.x
- shaka-packager

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
- Start shaka-packager container
```
docker run -v ${PWD}/:/media -it --rm google/shaka-packager
```
- Go to project directory
```
cd media
```

### DASH-MPEG
- Command
```
# Example
./scripts/package-dash.sh ./media/output/big-buck-bunny
```
- Generate file will be in `./media/package/<title>/dash`