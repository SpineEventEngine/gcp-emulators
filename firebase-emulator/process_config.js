#!/usr/bin/env node

/*
 * Copyright 2021, TeamDev. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Redistribution and use in source and/or binary forms, with or without
 * modification, must retain the above copyright notice and the following
 * disclaimer.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

const fs = require('fs');

const configFolder = "/firebase";
const configPath = `${configFolder}/firebase.json`;
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
    const denyAllStorageRules = `
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if false;
    }
  }
}
    `;
    console.info("Generating Storage security rules.", denyAllStorageRules);
    fs.writeFileSync(`${configFolder}/storage.rules`, denyAllStorageRules);
    const firebaseConfig = {
        "storage": {
            "rules": "./storage.rules"
        },
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
            },
            "storage": {
                "port": process.env.STORAGE_EMULATOR_PORT,
                "host": process.env.EMULATORS_HOST
            }
        }
    };
    console.info("Generating Firebase configuration.", firebaseConfig);
    fs.writeFileSync(configPath, JSON.stringify(firebaseConfig));
}
