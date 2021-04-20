# Build first time

$ docker build -t api .

# Enter database command line

$ docker container exec -it api /bin/sh

$ docker container exec -it postgres /bin/sh

   # psql --username postgres

# Enter rails shell

$ docker run -it api /bin/bash

# Run rails commands commands

$ docker run -it -v $PWD:/project api bundle install

$ docker run -it -v $PWD:/project -e database_host='postgresql-master' -e database_port='5432' --network docker_sundale-oms-network api <rails o rake command>

# run app

$ docker-compose -f docker-compose.yml up localstack mail redis postgresql-master mongo api 	