function toolbox {
  if [ "$(docker inspect toolbox | jq .[].State.Running)" == "false" ]; then
    docker start toolbox
  fi
  docker exec -it toolbox bash
}

