from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def home():
    return "Docker Health Check Application is Running!"

@app.route("/health")
def health():
    return {
        "status": "healthy",
        "message": "Application is working"
    }

@app.route("/info")
def info():
    return {
        "application": "Docker Health Check Demo",
        "hostname": os.uname().nodename
    }

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)