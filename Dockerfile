FROM ubuntu:precise

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y wget language-pack-en
RUN locale-gen en_US

ADD config /

RUN apt-key add /tmp/pgdg-apt-key.asc
RUN apt-get update
RUN apt-get install -y pgdg-keyring postgresql-9.3 postgresql-contrib-9.3 pwgen

# Create data dir
RUN service postgresql stop
RUN mkdir -p /data/main
RUN chown postgres:postgres /data/*
RUN chmod 700 /data/main
RUN su postgres --command "/usr/lib/postgresql/9.3/bin/initdb -D /data/main"

# Create user
ADD config-stage2 /
RUN /bin/docker-postgres-init-devdb

CMD /bin/docker-postgres-dev-server
EXPOSE 5432