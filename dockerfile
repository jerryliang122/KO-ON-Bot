# 设置基础镜像
FROM node:18.14.2

# 在容器内部创建工作目录
WORKDIR /app

# 将本地文件添加到工作目录中
ADD . /app

# 安装依赖项
RUN apt-get update && \
    apt-get install -y screen python3 python3-pip ffmpeg && \
    npm install --prefix ./MiguMusicApi && \
    npm install --prefix ./QQMusicApi && \
    npm install --prefix ./NeteaseCloudMusicApi && \
    pip install -r requirements.txt

# 设置环境变量
ENV PYTHONUNBUFFERED=1

# 运行命令
CMD screen -dmS KO-ON-scheduler python3 scheduler.py && \
    cd MiguMusicApi && screen -dmS KO-ON-MiguMusicApi npm start && cd ../ && \
    cd QQMusicApi && screen -dmS KO-ON-QQMusicApi npm start && cd ../ && \
    cd NeteaseCloudMusicApi && screen -dmS KO-ON-NeteaseCloudMusicApi node app.js && cd ../ && \
    screen -dmS KO-ON-core python3 core.py 1 && \
    tail -f /dev/null
