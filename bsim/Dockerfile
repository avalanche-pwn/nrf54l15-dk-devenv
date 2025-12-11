FROM ubuntu:latest

RUN apt -y update && apt -y upgrade
RUN apt install -y make gcc gcc-multilib python3-venv git

COPY ./fetch_and_build /scripts/fetch_and_build
RUN chmod +x /scripts/fetch_and_build

CMD ["/scripts/fetch_and_build"]
