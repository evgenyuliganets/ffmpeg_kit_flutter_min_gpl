#!/bin/bash

# Android AAR download
ANDROID_URL="https://github.com/evgenyuliganets/ffmpeg_kit_flutter_min_gpl/releases/download/v6.0/ffmpeg-kit-min-gpl-6.0-2.aar"
mkdir -p libs
curl -L $ANDROID_URL -o libs/ffmpeg-kit-min-gpl-6.0.aar