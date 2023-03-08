FROM node:18.14.2
RUN apt-get update && apt-get install -y python3 python3-pip ffmpeg screen
COPY . /KO-ON-Bot
WORKDIR /KO-ON-Bot
RUN cd QQMusicApi && npm install
RUN cd NeteaseCloudMusicApi && npm install
RUN cd MiguMusicApi && npm install 
RUN pip3 install -r requirements.txt
RUN chmod +x /KO-ON-Bot/run.sh
CMD ["bash", "-c", "./run.sh --start"]