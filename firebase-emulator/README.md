Firebase RDB emulator
---------

The [Firebase Realtime Database emulator][emulator] image allows reducing the hustle of setting up 
and configuring the emulator manually.

The easiest way to start the emulator is to run the following command:

```bash
docker run \
  --rm \
  -p=9000:9000 \
  -p=8080:8080 \
  -p=4000:4000 \
  -p=9099:9099 \
  -p=8085:8085 \
  -p=5001:5001 \
  --env "GCP_PROJECT=<your-gcp-project>" \
  spine3/firebase-emulator
```

The command above starts the container and exposes ports of all Firebase emulators.

## Configurations

The image is configured using a set of environment variables, and an optional shared volume with
the configuration files.

The `GCP_PROJECT` environment variable is the only one required and holds the name of the
GCP project for which the emulator is being started.

Other `EMULATOR_` environment variables configure the Firebase emulators suite and use
the same defaults as the emulator's suite.

| Env variable            | Service                 | Default value |
|-------------------------|-------------------------|---------------|
| RDB_EMULATOR_PORT       | Firebase Realtime DB    | 9000          |
| FIRESTORE_EMULATOR_PORT | Firestore               | 8080          |
| UI_EMULATOR_PORT        | Emulator suite UI       | 4000          |
| UI_ENABLED              | Emulator suite UI       | true          |
| AUTH_EMULATOR_PORT      | Firebase Authentication | 9099          |
| PUBSUB_EMULATOR_PORT    | Pub/Sub                 | 8085          |
| FUNCTIONS_EMULATOR_PORT | Firebase Functions      | 5001          |

The `EMULATORS_HOST` variable configures the host used by all the emulators and defaults to `0

Inside the container, the emulator is configured using the [`firebase.json`][firebase-config] 
located within the `/firebase` folder. The configuration file is generated on-the-fly from the
specified environment variables if none is supplied as a [volume][docker-volume].

### Mount custom Firebase configuration

It is also possible to mount a local `firebase.json` configuration to the `/firebase` folder and 
thus use any user-supplied configurations. In such case the environment variables do not have
any effect.

E.g. one may want to specify dedicated RDB security rules for the emulator with the following
`firebase.json` content and a `firebase-rules.json` available in the same folder as the config
file:

```json
{
  "database": {
    "rules": "firebase-rules.json"
  },
  "emulators": {
    "database": {
      "port": "9999",
      "host": "0.0.0.0"
    }
  }
}
```

Assuming the `firebase.json` and `firebase-rules.json` are available under the 
`$PWD/firebase_configs/` folder one can use the following command to use her own configurations 
over the default:

```bash
docker run \
    --name "firebase-emulator" \    
    --publish "9999:9999" \
    --volume "$PWD/firebase_configs:/firebase" \
    --rm \
    firebase-emulator
```

#### Start more emulators

With supplying a custom `firebase.json` one may benefit from configuring the emulators, and their 
respective rules as needed.

E.g. consider the following example that configures emulators with their respective setups
and also starts the [emulators UI][emulator-ui].

```json firebase.json
{
  "database": {
    "rules": "database.rules.json"
  },
  "hosting": {
    "target": "staging",
    "public": "dist/web-ui",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  },
  "emulators": {
    "database": {
      "port": "5000",
      "host": "0.0.0.0"
    },
    "ui": {
      "port": "4000",
      "host": "0.0.0.0"
    },
    "firestore": {
      "port": "8080",
      "host": "0.0.0.0"
    },
    "auth": {
      "port": "9099",
      "host": "0.0.0.0"
    },
    "hosting": {
      "port": "50033",
      "host": "0.0.0.0"
    }
  }
}
```

[emulator]: https://firebase.google.com/docs/emulator-suite/connect_rtdb
[firebase-config]: https://firebase.google.com/docs/cli#the_firebasejson_file
[emulator-ui]: https://firebase.google.com/docs/emulator-suite
[docker-volume]: https://docs.docker.com/storage/volumes/
