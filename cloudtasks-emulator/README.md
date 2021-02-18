Cloud Tasks emulator
---------

The [Cloud Tasks emulator][emulator] provides a way to work with the [Cloud Tasks][cloud-tasks] 
APIs locally.

The easiest way to start the emulator is to run the following command:

```bash
docker run \
  --rm \
  -p=9090:9090 \
  --env="GCP_PROJECT=<your-gcp-project>" \
  --volume="$PWD/appengine/configs:/configs" \
  spine3/cloudtasks-emulator
```

The command above starts the emulator and exposes it on the default `9090` port assuming
the caller application running on the `8080` port and the `queue.yaml` configuration available
under the `$PWD/appengine/configs` folder.

## Configuration

The image is configured using a set of environment variables, and a shared volume with 
the configuration files. 

The `GCP_PROJECT` environment variable is the only one required and holds the name of the 
GCP project for which the emulator is being started.

Also, one must mount `queue.yaml` configuration file to the `/configs` folder within the container.
It could be done using `--volume` parameter of the `docker run` command as noted above 
in the example.

### Optional configs

The queues location is configured by the `QUEUE_YAML_LOCATION` environment variable and defaults
to the `us-central1`.

The `QUEUE_YAML` environment variable allows redefining the location of the `queue.yaml` file 
within the container and defaults to `configs/queue.yaml`.

The `EMULATOR_PORT` allows configuring the port on which the emulator is started 
within the container.

The `TARGET_PORT` allows configuring the port of the caller application to which the emulator
will be sending the requests. It defaults to `8080`.

The `TARGET_HOST` environment variable tells the emulator to which host in the network 
to send the tasks. It usually should point to your local (docker host) IP address. By default, 
it is set to special DNS name of the container `host.docker.internal` which resolves to the 
internal IP address used by the host.


[emulator]: https://gitlab.com/potato-oss/google-cloud/gcloud-tasks-emulator
[cloud-tasks]: https://cloud.google.com/tasks
