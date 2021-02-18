#!/usr/bin/env sh
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

#
# This script starts the local CloudTasks emulator at the port denoted by the `EMULATOR_PORT`
# env variable or `9090` by default.
#
# The script expects the `QUEUE_YAML` env to have a fully-qualified path to the respective
# `queue.yaml` file. By default, set to `/configs/queue.yaml`.
#
# The `GCP_PROJECT` must be configured with the GCP project name.
#
# The `QUEUE_YAML_LOCATION` sets the GCP location of the queue and defaults to `us-central1`.
#
# Finally, the `TARGET_PORT` points to the port where the caller application expects to
# receive notifications from the CloudTasks on, The default value is `8080`.
# And the `TARGET_HOST` represents the host where the caller application runs. Usually, it should
# point to your local (docker host) IP address.
#

export GCP_PROJECT="${GCP_PROJECT}"
export QUEUE_YAML="${QUEUE_YAML:-/configs/queue.yaml}"
export QUEUE_YAML_LOCATION="${QUEUE_YAML_LOCATION:-us-central1}"
export EMULATOR_PORT="${EMULATOR_PORT:-9090}"
export TARGET_PORT="${TARGET_PORT:-8080}"
export TARGET_HOST="${TARGET_HOST:-host.docker.internal}"

python3 -m gcloud_tasks_emulator start \
  --port="${EMULATOR_PORT}" \
  --queue-yaml="${QUEUE_YAML}" \
  --queue-yaml-project="${GCP_PROJECT}" \
  --queue-yaml-location="${QUEUE_YAML_LOCATION}" \
  --target-port="${TARGET_PORT}" \
  --target-host="${TARGET_HOST}"
