echo -e "\e[36m"
echo "Building Jenkins image..."
docker build -t jenkins .
echo "Creating Jenkins container..."
docker run --rm -itd --name jenkins -p 8080:8080 -p 50000:50000 jenkins
echo "DONE"
