#
# Copyright 2021, TeamDev. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Redistribution and use in source and/or binary forms, with or without
# modification, must retain the above copyright notice and the following
# disclaimer.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

FROM node:lts-alpine3.12 AS app-env

LABEL "maintainer"="developers@spine.io"
LABEL "version"="1.0.0"
LABEL "io.spine.emulator"="Datastore"

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

COPY ./runner.sh ./process_config.js ./LICENSE /
RUN chmod +x /runner.sh

WORKDIR /firebase

ENTRYPOINT [ "/runner.sh" ]
