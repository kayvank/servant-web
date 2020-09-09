FROM haskell:8
    MAINTAINER Kayvan Kazeminejad <kayvan@q2io.com>
ENV PORT 3000
ENV APP_DIR /opt/app
RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR
EXPOSE $PORT

COPY . $APP_DIR

RUN \
    stack setup && \
    stack  build && \
    stack install && \
    stack  exec env && \
    ls -al && ls -al /root/.local/bin

CMD servant-web-exe
