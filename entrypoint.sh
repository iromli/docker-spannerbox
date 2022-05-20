#!/usr/bin/env bash

set -e

# turn on bash's job control
set -m

GOOGLE_SPANNER_ENDPOINT=http://0.0.0.0:9020

create_instance() {
    echo "[I] Creating Spanner instance $GOOGLE_SPANNER_INSTANCE_ID (if not exist) ..."

    curl \
        -S -s -o /dev/null \
        --request POST \
        -L "$GOOGLE_SPANNER_ENDPOINT/v1/projects/$GOOGLE_PROJECT_ID/instances" \
        --header 'Accept: application/json' \
        --header 'Content-Type: application/json' \
        --data "{\"instance\":{\"config\":\"emulator-config\",\"nodeCount\":1,\"displayName\":\"Test Instance\"},\"instanceId\":\"$GOOGLE_SPANNER_INSTANCE_ID\"}"
}

create_database() {
    echo "[I] Creating Spanner database $GOOGLE_SPANNER_DATABASE_ID (if not exist) ..."

    curl \
        -S -s -o /dev/null \
        --request POST \
        -L "$GOOGLE_SPANNER_ENDPOINT/v1/projects/$GOOGLE_PROJECT_ID/instances/$GOOGLE_SPANNER_INSTANCE_ID/databases" \
        --header 'Accept: application/json' \
        --header 'Content-Type: application/json' \
        --data "{\"createStatement\":\"CREATE DATABASE \`$GOOGLE_SPANNER_DATABASE_ID\`\"}"
}

# ==========
# entrypoint
# ==========

echo "[I] Starting Spanner emulator ..."
/gateway_main --hostname 0.0.0.0 --grpc_port 9010 --http_port 9020 &
sleep 5

create_instance
create_database

echo "[I] Initialization completed!!"

fg >/dev/null
