Cloud Storage Emulator
---------

The [Cloud Storage Emulator][emulator] provides a way to work with the [Cloud Storage][cloud-storage] 
APIs locally.

The easiest way to start the emulator is to run the following command:

```bash
docker run \
  --rm \
  -p=9199:9199 \
  spine3/cloudstorage-emulator
```

The command above starts the emulator and exposes it on the default `9199` port.

## Configuration

The image is configured using a set of environment variables, and a shared volume with 
the configuration files.

The `EMULATOR_PORT` allows configuring the port on which the emulator is started
within the container.

The `EMULATORS_HOST` variable configures the host used by the emulator and defaults to `0.0.0.0`.

[emulator]: https://github.com/googleapis/google-cloud-cpp/tree/main/google/cloud/storage/emulator
[cloud-storage]: https://cloud.google.com/storage
