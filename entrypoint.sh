#!/usr/bin/env bash

set -e

# turn on bash's job control
set -m

create_config() {
    echo "[I] Creating config for Spanner emulator"

    has_config=$(gcloud config configurations list | grep emulator) ||:
    if [ -z "$has_config" ]; then
        gcloud config configurations create emulator
    fi

    gcloud config set auth/disable_credentials true
    gcloud config set project "$GOOGLE_PROJECT_ID"
    gcloud config set api_endpoint_overrides/spanner http://0.0.0.0:9020/
}

create_instance() {
    echo "[I] Creating Spanner instance $SPANNER_INSTANCE_ID (if not exist)"

    has_instance=$(gcloud spanner instances list | grep "$SPANNER_INSTANCE_ID") ||:
    if [ -z "$has_instance" ]; then
        gcloud spanner instances create "$SPANNER_INSTANCE_ID" \
            --config=emulator-config --description="Test Instance" --nodes=1
    fi
}

create_database() {
    echo "[I] Creating Spanner database $SPANNER_DATABASE_ID (if not exist)"

    has_database=$(gcloud spanner databases list --instance="$SPANNER_INSTANCE_ID" | grep "$SPANNER_DATABASE_ID") ||:
    if [ -z "$has_database" ]; then
        gcloud spanner databases create "$SPANNER_DATABASE_ID" --instance="$SPANNER_INSTANCE_ID"
    fi
}

# ==========
# entrypoint
# ==========

/gateway_main --hostname 0.0.0.0 --grpc_port 9010 --http_port 9020 &
sleep 5

create_config
create_instance
create_database

echo "[I] Initialization completed!!"

fg >/dev/null
