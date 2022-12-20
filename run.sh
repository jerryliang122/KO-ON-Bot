#!/usr/bin/env bash
python3 scheduler.py
(cd MiguMusicApi  &&npm start & cd ../) &
(cd QQMusicApi  && npm start & cd ../) &
(cd NeteaseCloudMusicApi && node app.js & cd ../) &
python3 core.py 1

