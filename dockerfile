# 设置基础镜像
FROM python:3.10.10-slim-buster



# 安装依赖项
RUN apt-get update && \
    apt-get install -y wget curl gnupg && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get install -y screen nodejs yarn nasm yasm gcc g++ make pkg-config libx264-dev libx265-dev libvpx-dev

# 安装ffmpeg
RUN wget https://archive.mozilla.org/pub/opus/opus-1.3.1.tar.gz && \
    tar xzvf opus-1.3.1.tar.gz  && \
    cd opus-1.3.1  && \
    ./configure  && \
    make && make install  
RUN wget https://github.com/zeromq/libzmq/releases/download/v4.3.4/zeromq-4.3.4.tar.gz  && \
    tar xzvf zeromq-4.3.4.tar.gz && \
    cd zeromq-4.3.4 && \
    ./configure && \
    make && make install
RUN wget http://www.ffmpeg.org/releases/ffmpeg-4.3.2.tar.gz && \
    tar -xvf ffmpeg-4.3.2.tar.gz && \
    cd ffmpeg-4.3.2/ && \
    ./configure --enable-libopus --enable-libzmq  && \
    make && make install
# 在容器内部创建工作目录
WORKDIR /app

# 将本地文件添加到工作目录中
ADD . /app

# 安装依赖
RUN pip3 install -r requirements.txt &&\
    cd MiguMusicApi && yarn install && cd ../ && \
    cd QQMusicApi && yarn install && cd ../ && \
    cd NeteaseCloudMusicApi && yarn install && cd ../
# 设置环境变量
ENV PYTHONUNBUFFERED=1

# 运行命令
CMD screen -dmS KO-ON-scheduler python3 scheduler.py && \
    cd MiguMusicApi && screen -dmS KO-ON-MiguMusicApi npm start && cd ../ && \
    cd QQMusicApi && screen -dmS KO-ON-QQMusicApi npm start && cd ../ && \
    cd NeteaseCloudMusicApi && screen -dmS KO-ON-NeteaseCloudMusicApi node app.js && cd ../ && \
    screen -dmS KO-ON-core python3 core.py 1 && \
    tail -f /dev/null
