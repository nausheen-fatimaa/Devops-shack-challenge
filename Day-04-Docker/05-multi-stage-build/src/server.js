const http = require("http");

const PORT = 3000;

const server = http.createServer((req, res) => {
    res.writeHead(200, {
        "Content-Type": "text/html"
    });

    res.end(`
        <html>
            <head>
                <title>Multi-Stage Docker</title>
            </head>
            <body>
                <h1>Multi-Stage Docker Build</h1>
                <p>Application is running successfully.</p>
                <p>Built using Docker multi-stage builds.</p>
            </body>
        </html>
    `);
});

server.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});