echo -e "\e[91m"
echo "Killing/Removing Jenkins container..."
docker kill jenkins
echo "Removing Jenkins image..."
docker rmi jenkins:latest jenkinsci/blueocean
echo "DONE"
