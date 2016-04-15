#!/bin/bash

# *****************************************************
# Drools Workbench Showcase - Docker image build script
# *****************************************************

IMAGE_NAME="jboss/drools-workbench-showcase"
IMAGE_TAG="6.4.0.Final"

# Build the container image.
echo "Building the Docker container for $IMAGE_NAME:$IMAGE_TAG.."
docker build --rm -t $IMAGE_NAME:$IMAGE_TAG .
echo "Build done"
