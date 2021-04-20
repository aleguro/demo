var app  = require('express')();
var http = require('http').createServer(app);
var io   = require('socket.io')(http, {
  cors: {
    origin: '*',
    methods: ["GET", "POST"]
  }
});

io.on('connection', (socket) => {

    console.log('io.on:connection');

    socket.on('message', function(message) {

        try {

            console.log('socket.on:message');
            console.log(`emiting to ${message.channel}`)
            console.log(message);           

            io.emit('A', message);
        }
        catch(ex) {
            console.log(ex);
        }
        return {code: 200}
    });  
});

http.listen(3002, () => {

  console.log('listening on *:3002');
});