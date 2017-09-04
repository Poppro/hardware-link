var http = require('http');
var fs = require('fs');

function onRequest(request, response) {
    if(request.method == 'GET' && request.url == '/data.json') {
        fs.readFile('data.json', function (err, data) {
            if (err) {
                throw err;
            }
            response.writeHeader(200, {"Content-Type": "text/json"});
            response.write(data);
            response.end();
        });
    } else if(request.method == 'GET' && request.url == '/off') {
        process.exit();
    } else {
        response.writeHead(200, {"Content-Type": "text/plain"});
        response.write(__dirname);
        response.end();
    }
}

http.createServer(onRequest).listen(8888);
console.log("Server is now running");
