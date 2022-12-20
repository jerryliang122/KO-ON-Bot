FROM debian:11-slim
RUN apt-get update && apt-get install python3 python3-pip nodejs npm -y
COPY . /app
WORKDIR /app
RUN cd QQMusicApi && npm install
RUN cd NeteaseCloudMusicApi && npm install
RUN cd MiguMusicApi && npm install 
RUN pip3 install -r requirements.txt
CMD ["bash","run.sh"]