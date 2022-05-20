FROM gcr.io/cloud-spanner-emulator/emulator AS emulator

FROM debian:bookworm-slim

RUN apt-get update -y && apt-get install -y curl tini

COPY --from=emulator emulator_main /
COPY --from=emulator gateway_main /

ENV GOOGLE_PROJECT_ID=test-project \
    GOOGLE_SPANNER_INSTANCE_ID=test-instance \
    GOOGLE_SPANNER_DATABASE_ID=test-database

# =======
# cleanup
# =======

RUN rm -rf /var/lib/apt/lists/*

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["tini", "-g", "--"]
CMD ["bash", "entrypoint.sh"]
