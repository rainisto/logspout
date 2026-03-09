FROM golang:1.26.1-alpine3.23
ENTRYPOINT ["/bin/logspout"]
VOLUME /mnt/routes
EXPOSE 80
RUN apk update && apk upgrade --no-cache && apk add --upgrade zlib
COPY . /src
RUN cd /src && ./build.sh "$(cat VERSION)"

ONBUILD COPY ./build.sh /src/build.sh
ONBUILD COPY ./modules.go /src/modules.go
ONBUILD RUN cd /src && chmod +x ./build.sh && sleep 1 && sync && ./build.sh "$(cat VERSION)-custom"
