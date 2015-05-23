#!/bin/sh

# ***********************************************
# KIE Server Showcase - Docker image start script
# ************************************************

# Program arguments
#
# -c | --container-name:    The name for the created container.
#                           If not specified, defaults to "kie-server-showcase"
# -h | --help;              Show the script usage
#

CONTAINER_NAME="kie-server-showcase"
IMAGE_NAME="jboss/kie-server-showcase"
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
image_kie_server_workbench=$(docker run -P -d --name $CONTAINER_NAME $IMAGE_NAME:$IMAGE_TAG)
ip_kie_server_workbench=$(docker inspect $image_kie_server_workbench | grep IPAddress | awk '{print $2}' | tr -d '",')
echo $image_kie_server_workbench > docker.pid

# End
echo ""
echo "Server starting in $ip_kie_server_workbench"
echo "You can access the server root context in http://$ip_kie_server_workbench:8080"
echo "JBoss KIE Server is running at http://$ip_kie_server_workbench:8080/kie-server"

exit 0