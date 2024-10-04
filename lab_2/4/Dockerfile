FROM ubuntu:latest

RUN apt update && apt install -y iproute2 procps

COPY isolate.sh /usr/local/bin/isolate.sh

RUN chmod +x /usr/local/bin/isolate.sh

CMD ["/usr/local/bin/isolate.sh"]

#docker build -t isolate .
#docker run --name 4_test isolate