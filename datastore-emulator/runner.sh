#!/usr/bin/env sh

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
