FROM ubuntu
#FROM stackbrew/ubuntu:13.10
#MAINTAINER Tony Narlock <tony@git-pull.com>

EXPOSE 5432

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install build-essential -y
RUN apt-get install libreadline-dev zlib1g-dev flex bison libxml2-dev \
    libfl-dev libxslt1-dev libssl-dev libfl-dev python2.7-dev python-dev \
    libpam-dev tcl-dev libperl-dev git -y
RUN git clone git://git.postgresql.org/git/postgresql.git
RUN cd postgresql && git checkout REL9_3_1
RUN cd postgresql && ./configure --with-tcl --with-perl --with-python \
    --with-pam --with-openssl --with-libxml --with-libxslt \
    --mandir=/usr/local/share/postgresql/man \
    --docdir=/usr/local/share/doc/postgresql-doc \
    --sysconfdir=/etc/postgresql-common \
    --datarootdir=/usr/local/share \
    --datadir=/usr/local/share/postgresql \
    --bindir=/usr/local/lib/postgresql/bin \
    --libdir=/usr/local/lib \
    --libexecdir=/usr/local/lib/postgresql \
    --includedir=/usr/local/include/postgresql \
    --with-pgport=5432 \
    --enable-integer-datetimes \
    --enable-thread-safety \
    --enable-debug \
    --disable-rpath \
    --with-system-tzdata=/usr/share/zoneinfo
RUN cd postgresql && make
RUN cd postgresql && make install
RUN cd postgresql/contrib make all
RUN cd postgresql/contrib make install
RUN cp postgresql/contrib/start-scripts/linux /etc/init.d/postgresql 
RUN chmod +x /etc/init.d/postgresql
RUN update-rc.d postgresql defaults
RUN echo 'PATH=$PATH:/usr/local/lib/postgresql/bin; export PATH' > /etc/profile.d/postgresql.sh
RUN echo 'MANPATH=$MANPATH:/usr/local/postgresql/man; export MANPATH' >> /etc/profile.d/pgmanual.sh
RUN chmod 775 /etc/profile.d/postgresql.sh
RUN chmod 775 /etc/profile.d/pgmanual.sh
RUN . /etc/profile
RUN adduser postgres --disabled-password --gecos ""
#RUN adduser postgres --home /usr/local/pgsql --disabled-password --gecos ""
RUN mkdir -p /var/log/postgresql
RUN chown -R postgres:postgres /var/log/postgresql

RUN mkdir -p /var/lib/postgresql/data
RUN chown -R postgres:postgres /var/lib/postgresql/data
RUN /sbin/ldconfig /usr/local/lib/postgresql
#RUN su - postgres -c "/usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data"
RUN su - postgres -c "/usr/local/lib/postgresql/bin/initdb \
    -D /var/lib/postgresql/data"
#RUN su postgres sh -c "$INITDB $DATADIR"
RUN su postgres sh -c "/usr/local/lib/postgresql/bin/postgres --single \
    -D /var/lib/postgresql/data -c config_file=$CONF" | \
    echo "CREATE USER $USERNAME WITH SUPERUSER PASSWORD '$PASS';"

#RUN su - postgres -c "createuser -P -d -r -s docker"
#CMD service postgresql start && tail -F /usr/local/pgsql/data/serverlog
#CMD service postgresql start && /bin/bash

# ADD start /start
# RUN chmod 0755 /start
# CMD ["/start"]
RUN service postgresql start

#RUN su - postgres -c "createuser -P -d -r -s docker"
