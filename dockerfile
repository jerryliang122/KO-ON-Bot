FROM debian:11-slim
RUN apt-get update && apt-get install python3 python3-pip -y
COPY . /app
WORKDIR /app
RUN pip3 install -r requirements.txt
CMD ["bash","run.sh"]