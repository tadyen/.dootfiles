#!/usr/bin/sh

OLLAMA_INTPORT=11434
OLLAMA_EXTPORT=11434
WEBUI_INTPORT=8080
WEBUI_EXTPORT=3000

OLLAMA_CNAME="ollama"
WEBUI_CNAME="webui"

OLLAMA_CID=""
WEBUI_CID=""

# check and ensure docker.service is active
if ! systemctl is-active docker > /dev/null 2>&1 ; then
    systemctl start docker.socket
    echo "starting docker service...";
    while ! systemctl is-active docker > /dev/null 2>&1 ; do
        docker ps > /dev/null && sleep 0.25;
    done
fi;

# define container settings here
createContainer(){
    _container_name="$1"
    case $_container_name in
        "$OLLAMA_CNAME")
            docker run -d --gpus=all\
            -v ollama:/root/.ollama\
            -v asdf_docker_volume:/root/asdf\
            -p $OLLAMA_EXTPORT:$OLLAMA_INTPORT\
            --name ollama\
            --quiet\
            ollama/ollama ;;
        "$WEBUI_CNAME")
            docker run -d\
		    -v open-webui:/app/backend/data\
		    -v asdf_docker_volume:/root/asdf\
		    --add-host=host.docker.internal:host-gateway\
		    -p $WEBUI_EXTPORT:$WEBUI_INTPORT\
		    --name webui\
            --quiet\
		    ghcr.io/open-webui/open-webui:main ;;
        *)
            echo "unknown container $_container_name" ;;
    esac  
};

# retrieving container id
retrieveContainerId(){
    _container_name="$1"
    _container_id=$(docker container inspect --format="{{.Id}}" "$_container_name")
    case $_container_name in
        "$OLLAMA_CNAME")
            OLLAMA_CID=$_container_id ;;
        "$WEBUI_CNAME")
            WEBUI_CID=$_container_id ;;
        *)
            echo "unkown container $_container_name" ;;
    esac;
};

# stop containers on exit
stopContainerById(){
    for id in "$@"; do
        echo "stopping container: $id"
        docker stop "$id" -s "SIGTERM" -t 10 > /dev/null 2>&1;
    done
};
cleanup(){
    stopContainerById "$OLLAMA_CID" "$WEBUI_CID"
    echo "exited $0";
};
trap cleanup EXIT;

# run containers
for container_name in $OLLAMA_CNAME $WEBUI_CNAME; do
    # Check if the container exists
    if docker container inspect "$container_name" > /dev/null 2>&1; then
		# Check if the container is running
        if ! (docker container inspect -f '{{.State.Status}}' "$container_name" | grep -q "running") ; then
		    echo "The container $container_name is not running. Starting..."
		    docker start "$container_name" > /dev/null;
		fi
	    retrieveContainerId "$container_name";
	else
	    echo "The container $container_name does not exist. Creating container...."
	    createContainer "$container_name";
    fi
done;

echo "$OLLAMA_CNAME: $OLLAMA_CID  Running sh in container... PORTS EXT:INT : $OLLAMA_EXTPORT:$OLLAMA_INTPORT"
echo "$WEBUI_CNAME: $WEBUI_CID  PORTS EXT:INT : $WEBUI_EXTPORT:$WEBUI_INTPORT"
echo "Use \"ollama --help\" to get started."
echo "Ollama server should be running already, do not need to serve. Open webui via localhost:$WEBUI_EXTPORT"
docker exec -it "$OLLAMA_CID" sh;
