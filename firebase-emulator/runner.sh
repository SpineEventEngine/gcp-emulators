#!/usr/bin/env sh

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
export EMULATORS_HOST="${EMULATORS_HOST:-0.0.0.0}"

node /process_config.js

firebase emulators:start --project="${GCP_PROJECT}"
