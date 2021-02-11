FROM node:lts-alpine3.12 AS app-env

LABEL "maintainer"="developers@spine.io"
LABEL "version"="1.0.0"
LABEL "io.spine.emulator"="Firebase"

RUN apk add --no-cache python3 py3-pip openjdk11-jre && \
    npm install -g firebase-tools && \
    firebase setup:emulators:database && \
    firebase setup:emulators:firestore && \
    firebase setup:emulators:pubsub && \
    rm -rf /var/cache/apk/*

ENV GCP_PROJECT="change-me"
ENV RDB_EMULATOR_PORT="9000"
ENV FIRESTORE_EMULATOR_PORT="8080"
ENV UI_EMULATOR_PORT="4000"
ENV UI_ENABLED="true"
ENV AUTH_EMULATOR_PORT="9099"
ENV PUBSUB_EMULATOR_PORT="8085"
ENV FUNCTIONS_EMULATOR_PORT="5001"
ENV EMULATORS_HOST="0.0.0.0"

RUN mkdir /firebase
VOLUME /firebase

COPY ./runner.sh ./process_config.js /
RUN chmod +x /runner.sh

WORKDIR /firebase

ENTRYPOINT [ "/runner.sh" ]
