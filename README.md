[![CircleCI](https://circleci.com/gh/kayvank/servant-web.svg?style=svg)]( https://circleci.com/gh/kayvank/servant-web)



servant-web
--
A simple [servant](https://www.servant.dev/) http server using [docker](https://hub.docker.com/) and [circleci](https://circleci.com/)

## Prerequisite
- [stack](https://docs.haskellstack.org/en/stable/README/)
- [docker](https://www.docker.com/)
- [curl](https://curl.haxx.se/)

## building locally using stack

``` sh
stack set up
stack build 
stack install
stack run
```
For continues development and quick feedback:

``` sh
stack build --file-watch
```

## Publish the docker-image 
To publish your image to [docker hub](https://hub.docker.com/):

Prerequisite: docker hub account

``` sh
make
```
Prerequisite: [direvn](https://direnv.net/) 

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


## Resources

[servant-wpg 2015 paper](https://www.andres-loeh.de/Servant/servant-wgp.pdf)

[docker-image](https://circleci.com/)
[circlci build](https://circleci.com/)
