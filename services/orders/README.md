## First time initalization


# install watchman
# install aws cli
# install awslocal

```
$ cd services
$ make build
$ docker run --rm -it -v $PWD:/var/task -w /var/task lambci/lambda:build-ruby2.5
  
 # Need to put this in the docker file
	 $ cp -a /usr/lib64/*.so /var/task/lib/
	 $ cp /usr/lib64/libpq.so.5 /var/task/lib
	 $ bundle config --local build.pg --with-pg-config=/usr/lib64/pgsql92/
	 $ bundle config --local build.pg --with-pg-include=/usr/include/pgsql92
	 $ bundle config --local silence_root_warning true
	 $ bundle install --path vendor/bundle --clean
```

## Enter lambda command line

$ docker run -v $PWD:/var/task --network docker_rockethouse-network -it ruby-lambda /bin/bash 

## Upload lambda service first time

```
$ make local-create function=Order env=dev|production handler=Order
```

## Update lambda service

```
$ make update function=Producer env=dev|production

i.e.: $ make update function=Producer env=dev

```

## Test

```
$ make invoke function=Producer env=dev|production