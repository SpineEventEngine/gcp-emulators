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
# This script starts the local Datastore emulator at the port denoted by the `EMULATOR_PORT`
# env variable or `8081` by default.
#
# One may additionally configure the `EMULATOR_HOST_PORT` env variable to prevent running
# the emulator in the broadcast `0.0.0.0` mode. The `EMULATOR_PORT` is not used if a custom
# host-port env is set.
#
# The `GCP_PROJECT` must be configured with the GCP project name.
#
# The `DATASTORE_CONSISTENCY` sets the Datastore consistency level and defaults to `1.0`.
#

EMULATOR_PORT="${EMULATOR_PORT:-8081}"
DEFAULT_HOST_PORT="0.0.0.0:${EMULATOR_PORT}"

export GCP_PROJECT="${GCP_PROJECT}"
export EMULATOR_HOST_PORT="${EMULATOR_HOST_PORT:-$DEFAULT_HOST_PORT}"
export DATASTORE_CONSISTENCY="1.0"

gcloud beta emulators datastore start \
  --project="${GCP_PROJECT}" \
  --host-port="${EMULATOR_HOST_PORT}" \
  --consistency=${DATASTORE_CONSISTENCY} \
  --no-store-on-disk
