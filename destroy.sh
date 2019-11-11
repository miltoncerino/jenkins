echo "Killing/Removing Jenkins container..."
docker kill jenkins && \
echo "Removing Jenkins image..."
docker rmi jenkins:latest jenkins/jenkins:lts-alpine
echo "DONE"
