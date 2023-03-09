# 设置基础镜像
FROM python:3.10.10-slim-buster

# 在容器内部创建工作目录
WORKDIR /app

# 将本地文件添加到工作目录中
ADD . /app

# 安装依赖项
RUN apt-get update && \
    apt-get install -y nodejs npm screen && \
    npm install --prefix ./MiguMusicApi && \
    npm install --prefix ./QQMusicApi && \
    pip install -r requirements.txt

# 设置环境变量
ENV PYTHONUNBUFFERED=1

# 运行命令
CMD tail -f /dev/null
