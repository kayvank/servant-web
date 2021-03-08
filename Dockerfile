FROM haskell:8.8.4
    MAINTAINER Kayvan Kazeminejad <kayvan@q2io.com>
ENV PORT 3000
ENV APP_DIR /opt/app
RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR
EXPOSE $PORT

COPY . $APP_DIR

RUN \
    cabal update &&\
    cabal install

CMD servant-web-exe
