FROM python:3.10.9
RUN apt-get update && apt-get install nodejs npm git -y
RUN git clone https://github.com/jerryliang122/KO-ON-Bot.git --recursive
WORKDIR /KO-ON-Bot
RUN cd QQMusicApi && npm install
RUN cd NeteaseCloudMusicApi && npm install
RUN cd MiguMusicApi && npm install 
RUN pip3 install -r requirements.txt
CMD ["bash","run.sh"]