FROM python:3.7-stretch AS build-env

COPY requirements.txt /requirements.txt

RUN python3 -m pip install --upgrade pip
RUN pip install wheel setuptools

RUN pip install --requirement /requirements.txt --no-warn-script-location --no-cache-dir

FROM python:3.7-slim AS app-env
LABEL "maintainer"="developers@spine.io" \
      "emulator"="CloudTasks"

ENV GCP_PROJECT="change-me"
ENV EMULATOR_PORT="9090"
ENV QUEUE_YAML="/configs/queue.yaml"
ENV QUEUE_YAML_LOCATION="us-central1"
ENV TARGET_PORT="8080"
ENV TARGET_HOST="host.docker.internal"

RUN mkdir /configs
VOLUME /configs

COPY --from=build-env /usr/local/lib/python3.7/site-packages /usr/local/lib/python3.7/site-packages

COPY ./runner.sh /
RUN chmod +x /runner.sh

ENTRYPOINT [ "/runner.sh" ]
