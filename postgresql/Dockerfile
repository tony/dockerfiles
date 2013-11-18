FROM ubuntu
#MAINTAINER Tony Narlock <tony@git-pull.com>

EXPOSE 5432

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install build-essential -y
RUN apt-get install libreadline-dev zlib1g-dev flex bison libxml2-dev \
    libfl-dev libxslt1-dev libssl-dev libfl-dev python2.7-dev libpam-dev \
    tcl-dev libperl-dev git -y
RUN git clone git://git.postgresql.org/git/postgresql.git
RUN cd postgresql && ./configure --with-tcl --with-perl --with-python \
    --with-pam --with-openssl --with-libxml --with-libxslt \
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
RUN cp postgresql/contrib/start-scripts/linux  /etc/init.d/postgresql 
RUN chmod +x /etc/init.d/postgresql
RUN update-rc.d postgresql defaults
RUN echo 'PATH=$PATH:/usr/local/pgsql/bin; export PATH' > /etc/profile.d/postgresql.sh
RUN echo 'MANPATH=$MANPATH:/usr/local/pgsql/man; export MANPATH' >> /etc/profile.d/pgmanual.sh
RUN chmod 775 /etc/profile.d/postgresql.sh
RUN chmod 775 /etc/profile.d/pgmanual.sh
RUN . /etc/profile
RUN adduser postgres --home /usr/local/pgsql --disabled-password --gecos ""
RUN mkdir -p /var/log/pgsql
RUN chown -R postgres:postgres /var/log/pgsql/

RUN mkdir /usr/local/pgsql/data
RUN chown -R postgres:postgres /usr/local/pgsql/data
RUN su - postgres -c "/usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data"

CMD service postgresql start && tail /var/log/pgsql/pgsql.log

#RUN su - postgres -c "createuser -P -d -r -s docker"
