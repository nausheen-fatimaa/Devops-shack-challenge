from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return """
    <html>
        <head>
            <title>Docker Web Application</title>
        </head>
        <body>
            <h1>🚀 Dockerized Web Application</h1>
            <p>My application is running inside a Docker container.</p>
        </body>
    </html>
    """

@app.route("/health")
def health():
    return {"status": "healthy"}

app.run(host="0.0.0.0", port=5000)