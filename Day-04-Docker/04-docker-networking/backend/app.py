from flask import Flask
import socket

app = Flask(__name__)


@app.route("/")
def home():
    return {
        "service": "backend",
        "hostname": socket.gethostname(),
        "message": "Backend container is reachable"
    }


@app.route("/hello")
def hello():
    return {
        "message": "Hello from backend container"
    }


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)