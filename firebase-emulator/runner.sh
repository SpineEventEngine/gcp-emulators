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
# This script starts the local Firebase emulator with the configurations set
# via environment variables.
#
# The `RDB_EMULATOR_PORT` env configures the TCP port on which the Firebase Realtime DB emulator
# will be working on.
#
# The `FIRESTORE_EMULATOR_PORT` env configures the TCP port on which the Firestore emulator
# will be working on.
#
# The `UI_EMULATOR_PORT` env configures the TCP port on which the emulators suite UI
# will be working on. The `UI_ENABLED` env allows disabling the emulators suite UI if set to
# any value other than `true`.
#
# The `AUTH_EMULATOR_PORT` env configures the TCP port on which the Firebase Authentication emulator
# will be working on.
#
# The `PUBSUB_EMULATOR_PORT` env configures the TCP port on which the Pub/Sub emulator
# will be working on.
#
# The `FUNCTIONS_EMULATOR_PORT` env configures the TCP port on which the Firebase Functions emulator
# will be working on.
#
# One may additionally configure the `EMULATORS_HOST` env variable to prevent running
# the emulator in the broadcast `0.0.0.0` mode.
#

export GCP_PROJECT="${GCP_PROJECT}"
export RDB_EMULATOR_PORT="${RDB_EMULATOR_PORT:-9000}"
export FIRESTORE_EMULATOR_PORT="${FIRESTORE_EMULATOR_PORT:-8080}"
export UI_EMULATOR_PORT="${UI_EMULATOR_PORT:-4000}"
export UI_ENABLED="${UI_ENABLED:-true}"
export AUTH_EMULATOR_PORT="${AUTH_EMULATOR_PORT:-9099}"
export PUBSUB_EMULATOR_PORT="${PUBSUB_EMULATOR_PORT:-8085}"
export FUNCTIONS_EMULATOR_PORT="${FUNCTIONS_EMULATOR_PORT:-5001}"
export STORAGE_EMULATOR_PORT="${STORAGE_EMULATOR_PORT:-9199}"
export EMULATORS_HOST="${EMULATORS_HOST:-0.0.0.0}"

node /process_config.js

firebase emulators:start --project="${GCP_PROJECT}" --import /firebase/baseline-data
