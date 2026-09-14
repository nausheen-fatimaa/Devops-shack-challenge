from flask import Flask, jsonify
import mysql.connector
import os
import time

app = Flask(__name__)


@app.route("/api/health")
def health():

    return jsonify({
        "status": "healthy"
    })


@app.route("/api/database")
def database():

    try:

        connection = mysql.connector.connect(

            host=os.getenv("DB_HOST"),

            user=os.getenv("DB_USER"),

            password=os.getenv("DB_PASSWORD"),

            database=os.getenv("DB_NAME")
        )

        cursor = connection.cursor()

        cursor.execute("SELECT NOW()")

        result = cursor.fetchone()

        cursor.close()

        connection.close()

        return jsonify({

            "database": "connected",

            "time": str(result[0])

        })


    except Exception as error:

        return jsonify({

            "database": "failed",

            "error": str(error)

        }), 500


if __name__ == "__main__":

    app.run(

        host="0.0.0.0",

        port=5000

    )