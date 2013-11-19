Postgresql from source.

* Postgresql from official git VCS.
* Adjustable version by updating ``git checkout`` tag.
* Support for python, tcl, perl.
* Support for ``init.d`` service.
* Pure Dockerfile, no external shell scripts.

This ``Dockerfile`` compiles postgres from git and sets up a service with
the username and password ``docker`` and ``docker``.

Currently it uses the release ``9.3.1``.

The version can be adjusted by modifying the ``git checkout REL9_3_1` in
the ``Dockerfile``.

Building and debugging
======================

.. code-block:: bash

    sudo docker build -t="postgresql" .

.. code-block:: bash

    $ sudo docker run -i -t postgresql /bin/bash

    # and when inside:
    $ service postgresql start

Running
=======

.. code-block:: bash

    $ CONTAINER=$(sudo docker run -d -p 5432 \
        -t <your username>/postgresql)

    $ CONTAINER_IP=$(sudo docker inspect $CONTAINER | grep IPAddress | \
    awk '{ print $2 }' | tr -d ',"')

    # on your local machine postgres' client
    $ /usr/local/pgsql/bin/psql -p5432 -h $CONTAINER_IP --username='docker'\
    --password --list
