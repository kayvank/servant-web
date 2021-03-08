servant-web
--

A simple [servant](https://www.servant.dev/) http server 

## Prerequisite
- [stack](https://docs.haskellstack.org/en/stable/README/)
- [docker](https://www.docker.com/)
- [curl](https://curl.haxx.se/)
- [postgresql](https://www.archlinux.org/packages/?name=postgresql)

## building locally using stack

``` sh
stack set up
stack build 
```
For continues development and quick feedback:

``` sh
stack build --file-watch
```

## Publish the docker-image 
To publish your image to [docker hub](https://hub.docker.com/):


``` sh
make
```
Prerequisite: 
- [direvn](https://direnv.net/) 
-  docker hub account

## Execution
Project may run with `stack run` or as a docker image, and will require postgres.  To bring postgres up:

``` sh
./db/docker-compose up -d
docker ps ## to get the process id
docker inspect {process-id} 
```

### Execute docker image locally
To execute to image locally:

``` sh
docker run -p3000:3000 servant-web:latest
```

To test the deployment:


``` sh

docker inspect `docker images  | awdk '{printf $3}'` | grep IP
curl -v <IP>:3000/item 
```


## References

[servant-wpg 2015 paper](https://www.andres-loeh.de/Servant/servant-wgp.pdf)

[docker-image](https://hub.docker.com/repository/docker/kayvank/servant-web)

[circlci build](https://circleci.com/)
