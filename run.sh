#!/usr/bin/env bash
#(cd QQMusicApi && yarn start & cd ../) &
(cd NeteaseCloudMusicApi && node app.js & cd ../) &
nohup python3 bot.py & nohup python3 voice.py &
