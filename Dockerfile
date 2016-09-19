FROM gliderlabs/alpine:3.3
ENTRYPOINT ["/home/run.sh"]
VOLUME /mnt/routes
EXPOSE 8000

ADD run.sh /home/
WORKDIR /home
RUN chmod +x run.sh

ENV DOCKER unix:///tmp/docker.sock
ENV ROUTESPATH /mnt/routes

COPY . /src
RUN cd /src && ./build.sh "$(cat VERSION)"

ONBUILD COPY ./build.sh /src/build.sh
ONBUILD COPY ./modules.go /src/modules.go
ONBUILD RUN cd /src && ./build.sh "$(cat VERSION)-custom"
