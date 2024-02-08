ARG DENO_VERSION=1.40.3

FROM denoland/deno:bin-$DENO_VERSION AS deno
FROM ubuntu
COPY --from=deno /deno /usr/local/bin/deno

RUN         apt update \
            && apt -y install wget iproute2 git tzdata zip tar curl \
            && useradd -m -d /home/container container

    
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

STOPSIGNAL SIGINT

COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh
ENTRYPOINT    ["/usr/bin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]
