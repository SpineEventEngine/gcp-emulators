FROM gcr.io/google.com/cloudsdktool/cloud-sdk:alpine AS app-env

LABEL "maintainer"="developers@spine.io"
LABEL "version"="1.0.0"
LABEL "io.spine.emulator"="Datastore"

RUN apk add openjdk11-jre && \
    gcloud components remove anthoscli && \
    gcloud components install beta cloud-datastore-emulator && \
    rm -rf /var/cache/apk/* && \
    rm /google-cloud-sdk/data/cli/gcloud.json && \
    rm -rf /google-cloud-sdk/.install/.backup/ && \
    find /google-cloud-sdk/ -name "__pycache__" -type d  | xargs -n 1 rm -rf

ENV GCP_PROJECT="change-me"
ENV EMULATOR_PORT="8081"
ENV DATASTORE_CONSISTENCY="1.0"

COPY ./runner.sh /
RUN chmod +x /runner.sh

ENTRYPOINT [ "/runner.sh" ]
