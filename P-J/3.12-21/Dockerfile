FROM --platform=$TARGETOS/$TARGETARCH eclipse-temurin:21-jdk-jammy as builder
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

RUN apt-get update && apt-get install -y unzip
WORKDIR /gradle
RUN curl -L https://services.gradle.org/distributions/gradle-5.6.1-bin.zip -o gradle-5.6.1-bin.zip
RUN unzip gradle-5.6.1-bin.zip
ENV GRADLE_HOME=/gradle/gradle-5.6.1
ENV PATH=$PATH:$GRADLE_HOME/bin
RUN gradle --version

# # Stage 2: Gradle Build
# FROM gradle:5.6 AS builder
WORKDIR /app
COPY . .
RUN ./gradlew clean build
FROM --platform=$TARGETOS/$TARGETARCH python:3.12-slim-bookworm
COPY --from=builder /app/build /usr/lib/java


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
