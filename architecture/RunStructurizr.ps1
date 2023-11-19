docker pull structurizr/lite
docker run -it --rm --publish 8080:8080 --volume ${pwd}:/usr/local/structurizr structurizr/lite
