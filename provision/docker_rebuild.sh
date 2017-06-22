#! /bin/bash
sudo docker stop elk
sudo docker container rm elk
sudo docker image rm extended_elk
sudo docker build /vagrant/docker/. -t extended_elk
sudo docker run -d -p 5601:5601 -p 9200:9200 -p 5044:5044 -it --name elk extended_elk