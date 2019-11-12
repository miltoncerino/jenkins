#!/bin/bash
source tools/colors.cfg
source config/environment.cfg

function DeleteVolume {
  if docker volume inspect $1 > /dev/null; then
    echo "Deleting Jenkins data volume"
    docker volume rm $1
    if [ $? -eq 0 ]; then
      echo "Jenkins data volume has been removed"
    else
      echo "There was an error deleting the volume"
    fi
  else
    echo "Jenkins volume was not found"
  fi
}

echo -e ${COLOR_RED_LIGHT}

echo "Killing/Removing Jenkins container..."
docker kill ${JENKINS_CONTAINER_NAME}
echo "Removing Jenkins image..."
docker rmi ${JENKINS_IMAGE_NAME}:latest jenkinsci/blueocean

echo "Removing Docker volumes makes information unaccessible in the future."
read -p "Would you like to remove the Jenkins Docker volume? [y/N] " delVolume
case ${delVolume} in
     y)      
          DeleteVolume ${JENKINS_VOLUME}
          ;;
     *)
          ;;
esac

echo "DONE"