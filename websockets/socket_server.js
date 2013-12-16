#!/usr/bin/env node


var myconnection;
var WebSocketServer = require('websocket').server;
var http = require('http');
var myconnections = [];

var server = http.createServer(function(request, response) {
    console.log((new Date()) + ' Received request for ' + request.url);
    response.writeHead(404);
    response.end();
});
server.listen(8888, function() {
    console.log((new Date()) + ' Server is listening on port 8888');
});

wsServer = new WebSocketServer({
    httpServer: server,
    // You should not use autoAcceptConnections for production
    // applications, as it defeats all standard cross-origin protection
    // facilities built into the protocol and the browser.  You should
    // *always* verify the connection's origin and decide whether or not
    // to accept it.
    autoAcceptConnections: false
});

function originIsAllowed(origin) {
    // put logic here to detect whether the specified origin is allowed.
    return true;
}

process.stdin.resume();
process.stdin.setEncoding('utf8');
var util = require('util');

process.stdin.on('data', function(text) {
    console.log('received data:', util.inspect(text));
  	for ( myconnection in myconnections ) {
    		console.log('sendUTF: '+myconnection);
    		myconnections[myconnection].sendUTF(util.inspect(text));
		}
    if (text === 'quit\n') {
        done();
    }
});

function removeA(arr) {
	  var what, a = arguments, L = a.length, ax;
	  while (L > 1 && arr.length) {
	      what = a[--L];
	      while ((ax= arr.indexOf(what)) !== -1) {
	        	arr.splice(ax, 1);
	      }
	  }
	  return arr;
}

function done() {
    console.log('Now that process.stdin is paused, there is nothing more to do.');
    process.exit();
}

wsServer.on('request', function(request) {
    if (!originIsAllowed(request.origin)) {
        // Make sure we only accept requests from an allowed origin
        request.reject();
        console.log((new Date()) + ' Connection from origin ' + request.origin + ' rejected.');
        return;
    }

    var connection = request.accept('echo-protocol', request.origin);
    console.log("Pushing this value: " + connection);
    myconnections.push(connection);
    console.log((new Date()) + ' Connection accepted.');
    connection.on('message', function(message) {
        if (message.type === 'utf8') {
            console.log('Received Message: ' + message.utf8Data);
            connection.sendUTF(message.utf8Data);
        } else if (message.type === 'binary') {
            console.log('Received Binary Message of ' + message.binaryData.length + ' bytes');
            connection.sendBytes(message.binaryData);
        }
    });
    connection.on('close', function(reasonCode, description) {
        removeA(myconnections,connection);
        console.log((new Date()) + ' Peer ' + connection.remoteAddress + ' disconnected.');
    });
});
