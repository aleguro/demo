var socket = require('socket.io-client')('http://localhost:3002', {forceNew: true});

socket.on('connect', function(){
	
	console.log('conected');
	
	socket.on('A', function(data){
     console.log(data);
   });
});