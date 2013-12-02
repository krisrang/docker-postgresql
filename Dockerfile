FROM ubuntu:precise

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y wget language-pack-en
RUN locale-gen en_US

VOLUME ["/var/lib/postgresql/9.3/main"]

ADD config /

RUN apt-key add /tmp/pgdg-apt-key.asc
RUN apt-get update
RUN apt-get install -y pgdg-keyring postgresql-9.3 postgresql-contrib-9.3 pwgen

ADD config-stage2 /

RUN /bin/docker-postgres-init-devdb

CMD /bin/docker-postgres-dev-server
EXPOSE 5432