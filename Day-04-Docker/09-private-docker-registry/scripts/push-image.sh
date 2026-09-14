#!/bin/bash

IMAGE="secure-flask-app:v1"

REGISTRY="localhost:5000"

docker tag $IMAGE $REGISTRY/secure-flask-app:v1

docker push $REGISTRY/secure-flask-app:v1