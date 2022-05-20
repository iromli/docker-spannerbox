FROM debian:bookworm-slim AS gc

RUN apt-get update -y && apt-get install -y wget

RUN wget -q https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-386.0.0-linux-x86_64.tar.gz -O /tmp/cloudsdk.tar.gz \
    && tar xf /tmp/cloudsdk.tar.gz -C /opt/

FROM gcr.io/cloud-spanner-emulator/emulator AS emulator

FROM debian:bookworm-slim

RUN apt-get update -y && apt-get install -y python3 tini

COPY --from=gc /opt/google-cloud-sdk /opt/google-cloud-sdk
COPY --from=emulator emulator_main /
COPY --from=emulator gateway_main /

ENV PATH="/opt/google-cloud-sdk/bin:${PATH}" \
    GOOGLE_PROJECT_ID=test-project \
    GOOGLE_SPANNER_INSTANCE_ID=test-instance \
    GOOGLE_SPANNER_DATABASE_ID=test-database

# =======
# cleanup
# =======

RUN rm -rf /var/lib/apt/lists/*

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["tini", "-g", "--"]
CMD ["bash", "entrypoint.sh"]
