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

FROM python:3.7-stretch AS build-env

RUN python3 -m pip install --upgrade pip wheel setuptools

# Clone `google-cloud-cpp` repo in order to install the GCS emulator locally. Then go into the
# emulator folder and install required dependencies.
RUN git clone https://github.com/googleapis/google-cloud-cpp.git \
  --branch main \
  --single-branch \
  --depth 1 \
  /cloud-cpp \
  && cd "cloud-cpp/google/cloud/storage/emulator" \
  && rm -rf "tests" \
  && python3 -m pip install -r requirements.txt --no-warn-script-location --no-cache-dir

FROM python:3.7-slim AS app-env
LABEL "maintainer"="developers@spine.io"
LABEL "version"="1.0.0"
LABEL "io.spine.emulator"="CloudStorage"

RUN mkdir /configs
VOLUME /configs

# Copy installed Python packages from the build environment.
COPY --from=build-env /usr/local/lib/python3.7/site-packages /usr/local/lib/python3.7/site-packages
# Copy the emulator intself from the build environment.
COPY --from=build-env /cloud-cpp/google/cloud/storage/emulator /app
WORKDIR /app
COPY runner.sh .
RUN chmod +x runner.sh

ENV EMULATOR_PORT="9199"
ENV EMULATOR_HOST="0.0.0.0"

ENTRYPOINT [ "./runner.sh" ]
