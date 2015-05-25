#!/bin/sh

# ********************************************
# Drools Workbench - Docker image start script
# ********************************************

# Program arguments
#
# -c | --container-name:    The name for the created container.
#                           If not specified, defaults to "drools-workbench"
# -h | --help;              Show the script usage
#

CONTAINER_NAME="drools-workbench"
IMAGE_NAME="jboss/drools-workbench"
IMAGE_TAG="6.2.0.Final"

function usage
{
     echo "usage: start.sh [ [-c <container_name> ] ] [-h]]"
}

while [ "$1" != "" ]; do
    case $1 in
        -c | --container-name ) shift
                                CONTAINER_NAME=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

# Check if container is already started
if [ -f docker.pid ]; then
    echo "Container is already started"
    container_id=$(cat docker.pid)
    echo "Stoping container $container_id..."
    docker stop $container_id
    rm -f docker.pid
fi

# Start the docker container
echo "Starting $CONTAINER_NAME docker container using:"
echo "** Container name: $CONTAINER_NAME"
image_drools_workbench=$(docker run -P -d --name $CONTAINER_NAME $IMAGE_NAME:$IMAGE_TAG)
ip_drools_workbench=$(docker inspect $image_drools_workbench | grep IPAddress | awk '{print $2}' | tr -d '",')
echo $image_drools_workbench > docker.pid

# End
echo ""
echo "Server starting in $ip_drools_workbench"
echo "You can access the server root context in http://$ip_drools_workbench:8080"
echo "JBoss Drools Workbench is running at http://$ip_drools_workbench:8080/drools-wb"

exit 0