#!/bin/bash
source tools/colors.cfg
source config/environment.cfg

function CreateBackupDirectory {
  if [ -d $1 ]; then
    echo "Backup directory exists"
  else
    sudo mkdir $1 && \
    echo "Backup directory created"
  fi
}

function CreateVolume {
  if docker volume inspect $1 > /dev/null 2>&1; then
    echo "Jenkins volume is already created"
  else
    echo "Creating Jenkins data volume"
    docker volume create $1
    if [ $? -eq 0 ]; then
      echo "DONE"
    else
      echo "There was an error creating the volume"
    fi
  fi
}

echo -e ${COLOR_CYAN}

CreateBackupDirectory ${JENKINS_BACKUP_DIRECTORY}
CreateVolume ${JENKINS_VOLUME}

echo "Building Jenkins image..."
docker build -t ${JENKINS_IMAGE_NAME} .
echo "Creating Jenkins container..."
docker run \
  --rm \
  -itd \
  --name ${JENKINS_CONTAINER_NAME} \
  -p 8080:8080 \
  -p 50000:50000 \
  -v ${JENKINS_VOLUME}:/var/jenkins_home \
  -v ${JENKINS_BACKUP_DIRECTORY}:/var/backups \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -u root \
  ${JENKINS_IMAGE_NAME}
echo "DONE"

echo ""
echo "* You can inspect the recently created volume by running:"
echo "    docker volume inspect ${JENKINS_VOLUME}"
echo ""
echo "* You can find the mount point here:"
echo "    /var/lib/docker/volumes/${JENKINS_VOLUME}/_data"