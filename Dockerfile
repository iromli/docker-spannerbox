# ======
# gcloud
# ======

FROM debian:bookworm-slim AS src

RUN apt-get update -y \
    && apt-get install -y wget

ARG GCLOUD_VERSION=386.0.0-linux-x86_64
RUN wget -q https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${GCLOUD_VERSION}.tar.gz -O /tmp/cloudsdk.tar.gz \
    && tar xf /tmp/cloudsdk.tar.gz -C /opt/

ARG SPANNER_EMULATOR_VERSION=1.5.6
RUN wget -q https://storage.googleapis.com/cloud-spanner-emulator/releases/${SPANNER_EMULATOR_VERSION}/cloud-spanner-emulator_linux_amd64-${SPANNER_EMULATOR_VERSION}.tar.gz -O /tmp/spanner-emulator.tar.gz \
    && tar xf /tmp/spanner-emulator.tar.gz -C /opt

# =====
# tools
# =====

FROM golang:bullseye AS golang

RUN go install github.com/cloudspannerecosystem/spanner-cli@v0.9.15
RUN go install github.com/cloudspannerecosystem/spanner-dump@v0.2.1
RUN go install github.com/cloudspannerecosystem/spanner-truncate@a6eec6568c47f3ba6da61d9d4585c4353e0cc18b

# ===
# app
# ===

FROM debian:bookworm-slim

RUN apt-get update -y \
    && apt-get install -y python3 tini \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/spannerbox/bin

COPY --from=src /opt/google-cloud-sdk /opt/google-cloud-sdk
COPY --from=src /opt/emulator_main /opt/spannerbox/bin/
COPY --from=src /opt/gateway_main /opt/spannerbox/bin/
COPY --from=golang /go/bin/spanner-cli /opt/spannerbox/bin/
COPY --from=golang /go/bin/spanner-dump /opt/spannerbox/bin/
COPY --from=golang /go/bin/spanner-truncate /opt/spannerbox/bin/

COPY ./bin/ /opt/spannerbox/bin/
RUN chmod +x /opt/spannerbox/bin/emulator_main && chmod +x /opt/spannerbox/bin/gateway_main

ENV PATH="/opt/google-cloud-sdk/bin:/opt/spannerbox/bin:$PATH" \
    SPANNER_PROJECT_ID=test-project \
    SPANNER_INSTANCE_ID=test-instance \
    SPANNER_DATABASE_ID=test-database \
    SPANNER_EMULATOR_HOST=0.0.0.0:9010

ENTRYPOINT ["tini", "-g", "--"]
CMD ["emulator"]
