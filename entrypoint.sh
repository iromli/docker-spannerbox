#!/usr/bin/env bash

set -e
set -m

/gateway_main --hostname 0.0.0.0 --grpc_port 9010 --http_port 9020 &
sleep 5

echo "[I] Creating config for Spanner emulator"
if [ -z "$(gcloud config configurations list | grep emulator)" ]; then
    gcloud config configurations create emulator
fi
gcloud config set auth/disable_credentials true
gcloud config set project testing-project
gcloud config set api_endpoint_overrides/spanner http://0.0.0.0:9020/

echo "[I] Creating Spanner instance (if not exist)"
if [ -z "$(gcloud spanner instances list | grep testing-instance)" ]; then
    gcloud spanner instances create testing-instance \
        --config=emulator-config --description="Test Instance" --nodes=1
fi

echo "[I] Creating Spanner database (if not exist)"
if [ -z "$(gcloud spanner databases list --instance=testing-instance | grep testing-db)" ]; then
    gcloud spanner databases create testing-db --instance=testing-instance
fi

fg >/dev/null #%1
