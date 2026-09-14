from flask import Flask, jsonify
import mysql.connector
import os

app = Flask(__name__)


def get_db_connection():
    return mysql.connector.connect(
        host=os.getenv("DB_HOST", "database"),
        user=os.getenv("DB_USER", "root"),
        password=os.getenv("DB_PASSWORD", "rootpassword"),
        database=os.getenv("DB_NAME", "dockerdb")
    )


@app.route("/")
def home():
    return jsonify({
        "message": "Docker Persistent Database Demo"
    })


@app.route("/add/<name>")
def add_user(name):
    connection = get_db_connection()
    cursor = connection.cursor()

    cursor.execute(
        "INSERT INTO users (name) VALUES (%s)",
        (name,)
    )

    connection.commit()

    cursor.close()
    connection.close()

    return jsonify({
        "message": f"User {name} added successfully"
    })


@app.route("/users")
def get_users():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    cursor.execute("SELECT * FROM users")
    users = cursor.fetchall()

    cursor.close()
    connection.close()

    return jsonify(users)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)