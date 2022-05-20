# ======
# gcloud
# ======

FROM debian:bookworm-slim AS gcloud

RUN apt-get update -y \
    && apt-get install -y wget

ARG GCLOUD_VERSION=386.0.0-linux-x86_64
RUN wget -q https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${GCLOUD_VERSION}.tar.gz -O /tmp/cloudsdk.tar.gz \
    && tar xf /tmp/cloudsdk.tar.gz -C /opt/

# ========
# emulator
# ========

FROM gcr.io/cloud-spanner-emulator/emulator AS emulator

# =====
# tools
# =====

FROM golang:bullseye AS golang

ARG SPANNER_CLI_VERSION=v0.9.11
RUN go install github.com/cloudspannerecosystem/spanner-cli@${SPANNER_CLI_VERSION}

# ===
# app
# ===

FROM debian:bookworm-slim

RUN apt-get update -y \
    && apt-get install -y python3 tini \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/spannerbox/bin

COPY --from=emulator emulator_main /opt/spannerbox/bin/
COPY --from=emulator gateway_main /opt/spannerbox/bin/
COPY --from=golang /go/bin/spanner-cli /opt/spannerbox/bin/
COPY --from=gcloud /opt/google-cloud-sdk /opt/google-cloud-sdk

COPY ./bin/ /opt/spannerbox/bin/

ENV PATH="/opt/google-cloud-sdk/bin:/opt/spannerbox/bin:$PATH" \
    SPANNER_PROJECT_ID=test-project \
    SPANNER_INSTANCE_ID=test-instance \
    SPANNER_DATABASE_ID=test-database

ENTRYPOINT ["tini", "-g", "--"]
CMD ["emulator"]
