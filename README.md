PostgreSQL 9.3 image
===

Run command

    docker run -d -name postgresql -p 5432:5432 -v /data/postgres:/data/main pebbles/postgresql
    
Logins
* User: docker
* Password: docker

Persistent storage
---
This image uses persistent storage that located at /data/main in the image