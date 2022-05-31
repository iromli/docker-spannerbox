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

RUN go install github.com/cloudspannerecosystem/spanner-cli@v0.9.11
RUN go install github.com/cloudspannerecosystem/spanner-dump@v0.2.1
RUN go install github.com/cloudspannerecosystem/spanner-truncate@51fa1cbec834b47670238dfb6ef590459514f862

# ===
# app
# ===

FROM debian:bookworm-slim

RUN apt-get update -y \
    && apt-get install -y python3 tini \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/spannerbox/bin

COPY --from=gcloud /opt/google-cloud-sdk /opt/google-cloud-sdk
COPY --from=emulator emulator_main /opt/spannerbox/bin/
COPY --from=emulator gateway_main /opt/spannerbox/bin/
COPY --from=golang /go/bin/spanner-cli /opt/spannerbox/bin/
COPY --from=golang /go/bin/spanner-dump /opt/spannerbox/bin/
COPY --from=golang /go/bin/spanner-truncate /opt/spannerbox/bin/

COPY ./bin/ /opt/spannerbox/bin/

ENV PATH="/opt/google-cloud-sdk/bin:/opt/spannerbox/bin:$PATH" \
    SPANNER_PROJECT_ID=test-project \
    SPANNER_INSTANCE_ID=test-instance \
    SPANNER_DATABASE_ID=test-database \
    SPANNER_EMULATOR_HOST=0.0.0.0:9010

ENTRYPOINT ["tini", "-g", "--"]
CMD ["emulator"]
