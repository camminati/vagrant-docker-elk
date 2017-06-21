sudo apt-get update -qq

#because jmacs
sudo apt-get install -yqq joe
#zsh
sudo apt-get install -yqq zsh
sudo apt-get install -yqq git-core
wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
sudo chsh -s /bin/zsh ubuntu > /dev/null
zsh

# Docker CE
# sudo apt-get install -yqq \
#     linux-image-extra-$(uname -r) \
#     linux-image-extra-virtual
### Install packages to allow apt to use a repository over HTTPS
sudo apt-get install  -yqq\
apt-transport-https \
ca-certificates \
curl \
software-properties-common
### dd Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

### Verify that the key fingerprint is 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88
sudo apt-key fingerprint 0EBFCD88
### TODO verify some time ..
sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
stable"

sudo apt-get update -qq

sudo apt-get install -yqq docker-ce

## setup virtual memory for elastic search
sudo sysctl -w vm.max_map_count=262144

## get/install the image: sebp/elk
echo "Now the installation of the docker images... be patient!"
if [ ! -f /vagrant/docker/images/sebp_elk.tar.gz ]; then
    echo "Pulling sebp/elk from the net"
    sudo docker pull sebp/elk
    echo "Saving it for the next time."
    sudo docker save sebp/elk -o /vagrant/docker/images/sebp_elk.tar
    sudo gzip /vagrant/docker/images/sebp_elk.tar
else
    echo "Installing local sebp/elk"
    sudo docker load < /vagrant/docker/images/sebp_elk.tar.gz
fi

## building Dockerfile
echo "Building Dockerfile from /vagrant/docker/Dockerfile"
sudo docker build /vagrant/docker/. -t extended_elk
echo "done!"

## starting docker container
echo "Starting docker container sebp/elk..."
sudo docker run -d -p 5601:5601 -p 9200:9200 -p 5044:5044 -it --name elk extended_elk
echo "done!"



echo "alias elk-start='sudo docker container start elk'" | tee --append .zshrc > /dev/null
echo "alias elk-stop='sudo docker container stop elk'" | tee --append .zshrc > /dev/null
echo "alias elk-bash='sudo docker exec -i -t elk /bin/bash'"| tee --append .zshrc > /dev/null
echo "You may no do 'vagrant ssh' and elk-start|elk-stop|elk-bash"
