# To start the project run boot.sh

# In one console

$ cd docker
$ ./boot.sh

# In other console

$ cd services/orders
$ make boot
$ awslocal sns publish --topic-arn "arn:aws:sns:eu-west-1:000000000000:order_topic" \--message '{ "idd": 1, "body": "This is the body", "items": [ { "cost": 10.0, "name": "Item #1", "quantity": 2}], "title": "Testing mutation"}'
