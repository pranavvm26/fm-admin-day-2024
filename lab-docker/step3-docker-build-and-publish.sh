#!/bin/bash

docker build --network sagemaker --tag my-custom-image --file ./Dockerfile .

aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin xxxx.dkr.ecr.us-east-2.amazonaws.com

docker tag my-custom-image xxxx.dkr.ecr.us-east-2.amazonaws.com/my_studio_images:v1

docker push xxxx.dkr.ecr.us-east-2.amazonaws.com/my_studio_images:v1
