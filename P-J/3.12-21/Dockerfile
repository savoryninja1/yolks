FROM --platform=$TARGETOS/$TARGETARCH eclipse-temurin:21-jdk-jammy as builder

FROM --platform=$TARGETOS/$TARGETARCH python:3.12-slim-bookworm

COPY --from=builder . /usr/local/bin/

RUN         apt update \
            && apt -y install ffmpeg wget iproute2 git sqlite3 libsqlite3-dev python3 python3-dev ca-certificates dnsutils tzdata zip tar curl build-essential libtool iputils-ping libnss3 tini \
            && useradd -m -d /home/container container

    
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

STOPSIGNAL SIGINT

COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh
ENTRYPOINT    ["/usr/bin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]
