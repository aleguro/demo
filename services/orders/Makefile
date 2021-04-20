build:
	docker build -t ruby-lambda .

bundle:
	docker run --rm -v $(PWD):/var/task ruby-lambda bundle install

package:
	rm -f deploy.zip
	zip -q -r deploy.zip . -x .git/\*

clean:
	rm -rf .bundle/
	rm -rf vendor/
	rm -rf lib/

run:
	docker run --rm -v "$PWD":/var/task:ro,delegated lambci/lambda:ruby2.5 order.lambda_handler

console:
	docker run -v $PWD:/var/task --network docker_rockethouse-network -it ruby-lambda /bin/bash 

local-create-exp:
	awslocal lambda create-function \
	--function-name $(function)-$(env) \
  --code S3Bucket="__local__",S3Key="/Users/alejandrogurovich/code/rockethouse/services" \
  --handler $(handler).main \
  --runtime ruby2.5 \
  --timeout 10 \
  --role whatever

local-create:
	make package	
	awslocal lambda create-function \
		--region eu-west-1 \
		--function-name $(function)-$(env) \
		--zip-file fileb://deploy.zip \
		--runtime ruby2.5 \
		--role fake_role \
		--timeout 20 \
		--handler $(handler).main \
    --environment '{"Variables":{"host":"postgresql-master", "username":"postgres", "password":"postgres", "database":"demo", "port":"5432"}}'

local-update:
	make package	
	awslocal lambda update-function-code \
    --function-name $(function)-$(env) \
    --zip-file fileb://deploy.zip

boot:
	make local-create function=Order env=dev handler=order

	awslocal sns create-topic --name order_topic 
	
	awslocal sqs create-queue --queue-name order_queue;
	
	awslocal sns subscribe --topic-arn arn:aws:sns:eu-west-1:000000000000:order_topic --protocol sqs --notification-endpoint http://localstack:4576/queue/order_queue
	
	awslocal lambda create-event-source-mapping --event-source-arn arn:aws:sqs:eu-west-1:000000000000:order_queue --function-name Order-dev

reboot:
	make package	
	awslocal lambda update-function-code \
    --function-name Order-dev \
    --zip-file fileb://deploy.zip

create:
	make package	
	aws lambda create-function \
			--region us-east-1 \
			--function-name $(function)-$(env) \
			--zip-file fileb://deploy.zip \
			--runtime ruby2.5 \
			--role arn:aws:iam::261776247340:role/service-role/PushOrderQue-role-8jagycgd \
			--timeout 20 \
			--handler $(handler).main

update:
	make package
	aws lambda update-function-code \
			--region us-east-1 \
			--function-name $(function)-$(env) \
			--zip-file fileb://deploy.zip 

delete:
	aws lambda delete-function \
			--region us-east-1 \
			--function-name $(function)-$(env)

invoke:
	aws lambda invoke \
		--region us-east-1 \
		--function-name $(function)-$(env) /dev/stdout
