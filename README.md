Spine GCP emulators
---------

This repository holds a set of containerized Google Cloud Platform emulators used in development 
and testing purposes.

# The emulators

We currently provide the following emulators.

## Cloud Tasks

The [Cloud Tasks emulator][cloud-tasks-emulator] provides a way to work with 
the [Cloud Tasks][cloud-tasks] APIs locally.

See [cloudtasks-emulator](./cloudtasks-emulator) folder for additional details.

Or start the emulator with the following command:

```bash
cat <<EOT >> queue.yaml
queue:
  - name: default
    rate: 1/s
EOT

docker run \
  --rm \
  -p=9090:9090 \
  --env="GCP_PROJECT=my-project" \
  --volume="$PWD/queue.yaml:/configs/queue.yaml" \
  spine3/cloudtasks-emulator
```

[cloud-tasks-emulator]: https://gitlab.com/potato-oss/google-cloud/gcloud-tasks-emulator
[cloud-tasks]: https://cloud.google.com/tasks

## Datastore

The [Datastore emulator][datastore-emulator] image allows starting the emulator without the need
of installing and configuring it locally.

See [datastore-emulator](./datastore-emulator) folder for additional details.

Or start the emulator with the following command:

```bash
docker run \
  --rm \
  -p=8081:8081 \
  --env "GCP_PROJECT=my-project" \
  spine3/datastore-emulator
```

[datastore-emulator]: https://cloud.google.com/sdk/gcloud/reference/beta/emulators/datastore

## Firebase

The [Firebase emulator][firebase-emulator] image allows reducing the hustle of setting up
and configuring the emulator manually.

See [firebase-emulator](./firebase-emulator) folder for additional details.

Or start the emulator with the following command:

```bash
docker run \
  --rm \
  -p=9000:9000 \
  -p=8080:8080 \
  -p=4000:4000 \
  -p=9099:9099 \
  -p=8085:8085 \
  -p=5001:5001 \
  --env "GCP_PROJECT=my-project" \
  spine3/firebase-emulator
```

By default, the container starts the whole Firebase [emulators suite][firebase-emulator] and
the command above exposes their TCP ports.

[firebase-emulator]: https://firebase.google.com/docs/emulator-suite

# Docker Compose

You can find an example [Docker Compose][docker-compose] [configuration](./docker-compose.yml) 
that one may use to start up the emulators altogether with just a single 
`docker-compose up` command.

[docker-compose]: https://docs.docker.com/compose/

# GCP Container Registry

Sometimes usage of the public [Docker Hub][docker-hub] images may be not a good idea due 
to the security restrictions or images pull performance/cost implications.

For such a use case we provide a reusable [Cloud Build][cloud-build] configurations that allows 
building and deploying the emulators to a private [Google Container Registry][gcr] images registry.

Look for a `cloudbuild.yaml` file in the emulator folders, and a top-level [one](./cloudbuild.yaml) 
to build them all together.

[docker-hub]: https://hub.docker.com/
[cloud-build]: https://cloud.google.com/cloud-build
[gcr]: https://cloud.google.com/container-registry/
