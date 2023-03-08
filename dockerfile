FROM node:18.14.2
RUN apt-get update && apt-get install -y python3 python3-pip ffmpeg
RUN git clone https://github.com/jerryliang122/KO-ON-Bot.git --recursive
WORKDIR /KO-ON-Bot
RUN cd QQMusicApi && npm install
RUN cd NeteaseCloudMusicApi && npm install
RUN cd MiguMusicApi && npm install 
RUN pip3 install -r requirements.txt
CMD ["bash","./run.sh --start"]