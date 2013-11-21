#!/bin/bash

CONTAINER=$(sudo docker run -v /var/lib/postgresql/docker:/var/lib/postgres -d -p 5432 -t postgresql)
echo $CONTAINER
CONTAINER_IP=$(sudo docker inspect $CONTAINER | grep IPAddress | awk '{ print $2
}' | tr -d ',"')
echo $CONTAINER_IP
echo "psql -p5432 -h $CONTAINER_IP --username='docker' --password"
psql -p5432 -h $CONTAINER_IP --username='docker' --password --list
