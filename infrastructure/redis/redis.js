var redis       = require("redis");
var subscriber  = redis.createClient(6379, 'redis');
const io        = require('socket.io-client')
const socket    = io('http://socket-server:3002');

subscriber.on("pmessage", function (pattern, channel, message) {

    console.log('subscribing');

    try {

        var jsonMessage = JSON.parse(message)

        console.log(`jsonMessage: ${jsonMessage}`);

        socket.emit('message', jsonMessage);
    }
    catch(ex) {
        console.log(ex);
    }
});

console.log('Redis gateway running');
subscriber.psubscribe("*");