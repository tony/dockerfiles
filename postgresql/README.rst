
Commands

.. code-block:: bash

    sudo docker run -i -t postgresql /bin/bash


FAQ and Notes
-------------

Why the ``start`` script.

Docker's ``RUN`` isn't intended to be used for running processes, but
commands. In order to create the default user, the database must be
running.

Postgres' ``initdb`` works ok with ``RUN``, as it starts the database on
its own. It's possible we may not have to use this, we can experiment
using ``RUN`` with::

  su postgres sh -c "$POSTGRES --single -D $DATADIR -c config_file=$CONF"
  <<< "CREATE USER $USERNAME WITH SUPERUSER PASSWORD '$PASS';"

Source: https://github.com/stigi/dockerfile-postgresql/blob/master/start

