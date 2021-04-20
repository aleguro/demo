# Compile

$ docker build -t gateway .

# Run docker shell and test
$ docker run --rm -v $PWD:/var/task -v /Users/alejandrogurovich/code/rockethouse/demo/services/orders:/var/services/orders --network docker_rockethouse-network -it gateway /bin/bash

	$ ruby gateway.rb

	$ vendor/bundle/ruby/2.5.0/bin/rerun --dir /var/task ruby gateway.rb