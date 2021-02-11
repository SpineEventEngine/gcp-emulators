#!/usr/bin/env node

const fs = require('fs');

const configPath = "/firebase/firebase.json";
if (!fs.existsSync(configPath)) {
    generateConfig();
} else {
    logCurrentConfig();
}

/**
 * Reads the Firebase RDB configuration and logs it.
 */
function logCurrentConfig() {
    const rawContent = fs.readFileSync(configPath);
    const existingConfig = JSON.parse(rawContent);
    console.info("Using existing Firebase configuration.", existingConfig);
}

/**
 * Generates a custom Firebase RDB configuration based on the `EMULATOR_PORT` and `EMULATOR_HOST`
 * environment variables.
 */
function generateConfig() {
    const firebaseConfig = {
        "emulators": {
            "firestore": {
                "port": process.env.FIRESTORE_EMULATOR_PORT,
                "host": process.env.EMULATORS_HOST
            },
            "ui": {
                "enabled": process.env.UI_EMULATOR_PORT === "true",
                "port": process.env.UI_EMULATOR_PORT,
                "host": process.env.EMULATORS_HOST
            },
            "auth": {
                "port": process.env.AUTH_EMULATOR_PORT,
                "host": process.env.EMULATORS_HOST
            },
            "functions": {
                "port": process.env.FUNCTIONS_EMULATOR_PORT,
                "host": process.env.EMULATORS_HOST
            },
            "database": {
                "port": process.env.RDB_EMULATOR_PORT,
                "host": process.env.EMULATORS_HOST
            },
            "pubsub": {
                "port": process.env.PUBSUB_EMULATOR_PORT,
                "host": process.env.EMULATORS_HOST
            }
        }
    };
    console.info("Generating Firebase configuration.", firebaseConfig);
    fs.writeFileSync(configPath, JSON.stringify(firebaseConfig));
}
