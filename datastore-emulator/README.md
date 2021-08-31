Datastore Emulator
---------

The [Datastore Emulator][emulator] image allows starting the emulator without the need
to installing and configuring it locally.

The easiest way to start the emulator is to run the following command:

```bash
docker run \
  --rm \
  -p=8081:8081 \
  --env "GCP_PROJECT=<your-gcp-project>" \
  spine3/datastore-emulator
```

The command above starts the emulator and exposes it on the default `8081` port.

## Configurations

The image is configured using a set of environment variables. The `GCP_PROJECT` environment
variable is the only one required and holds the name of the GCP project for which the emulator 
is being started.

The `EMULATOR_PORT` allows configuring the port on which the emulator is started 
within the container.

The `DATASTORE_CONSISTENCY` allows configuring the [consistency][consistency] level of the emulator.

[emulator]: https://cloud.google.com/sdk/gcloud/reference/beta/emulators/datastore
[consistency]: https://cloud.google.com/sdk/gcloud/reference/beta/emulators/datastore/start#--consistency
