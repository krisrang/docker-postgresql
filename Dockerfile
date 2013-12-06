FROM ubuntu:precise

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y wget language-pack-en
RUN locale-gen en_US

ADD config /

RUN apt-key add /tmp/pgdg-apt-key.asc
RUN apt-get update
RUN apt-get install -y pgdg-keyring postgresql-9.3 postgresql-contrib-9.3 pwgen

RUN service postgresql stop
ADD config-stage2 /

EXPOSE 5432
VOLUME ["/data/main"]

CMD /bin/docker-postgres-server