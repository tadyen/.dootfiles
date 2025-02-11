#!/usr/bin/sh

OLLAMA_INTPORT=11434
OLLAMA_EXTPORT=11434
WEBUI_INTPORT=8080
WEBUI_EXTPORT=3000

OLLAMA_CNAME="ollama"
WEBUI_CNAME="webui"

OLLAMA_CID=$(
    docker run -d --gpus=all\
    -v ollama:/root/.ollama\
    -v asdf_docker_volume:/root/asdf\
    -p $OLLAMA_EXTPORT:$OLLAMA_INTPORT\
    --name ollama\
    ollama/ollama
);

WEBUI_CID=$(
    docker run -d\
    -v open-webui:/app/backend/data\
    -v asdf_docker_volume:/root/asdf\
    --add-host=host.docker.internal:host-gateway\
    -p $WEBUI_EXTPORT:$WEBUI_INTPORT\
    --name webui\
    ghcr.io/open-webui/open-webui:main
);

function cleanup()
{
	docker stop $OLLAMA_CID
	docker stop $WEBUI_CID
	echo "exited $0"
}
trap cleanup EXIT

echo "Docker container id: $DOCKER_CID  Running sh in container... PORTS EXT:INT : $OLLAMA_EXTPORT:$OLLAMA_INTPORT"
echo "WebUI container id: $WEBUI_CID  PORTS EXT:INT : $WEBUI_EXTPORT:$WEBUI_INTPORT"
echo "Use \"ollama --help\" to get started."
echo "Ollama server should already be running in this container. Open webui via localhost:$WEBUI_EXTPORT"
docker exec -it $OLLAMA_CID sh
