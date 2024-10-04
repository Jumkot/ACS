FROM ubuntu:latest

RUN apt update && apt install -y gcc

COPY signal.c /app/signal.c

WORKDIR /app

RUN gcc -o signal signal.c

CMD ["./signal"]

#docker build -t signal .
#docker run --name SIG signal
# cgroups - ограничение ресурсов:
#docker run -d --name SIG --memory 256m --cpus 1 signal