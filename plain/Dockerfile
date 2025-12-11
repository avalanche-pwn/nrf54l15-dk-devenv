FROM ubuntu:latest
WORKDIR /workspace

RUN apt -y update && apt -y upgrade
RUN apt install -y make gcc gcc-multilib python3-venv git

COPY init.sh /init
RUN chmod +x /init
RUN /init

RUN echo "source /.venv/bin/activate" >> /root/.bashrc
