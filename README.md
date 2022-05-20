# spannerbox

`spannerbox` is an image contains pre-configured Spanner emulator.

The image includes `gcloud` to initialize config, instance, and database.

## Usage

The following environment variables can be used to customize `spannerbox` container:

- `GOOGLE_PROJECT_ID`: Google project ID (default to `test-project`)
- `SPANNER_INSTANCE_ID`: Spanner instance ID (default to `test-instance`)
- `SPANNER_DATABASE_ID`: Spanner Database ID (default to `test-database`)

Example of running `spannerbox` using `docker`:

```
docker run \
    -p 9010:9010 \
    -e PROJECT_ID=test-project \
    -e INSTANCE_ID=test-instance \
    -e DATABASE_ID=test-database \
    iromli/spannerbox:$VERSION
```

See [Releases](https://github.com/iromli/docker-spannerbox/releases) for latest stable `$VERSION`.

The database can be accessed using [spanner-cli](https://github.com/cloudspannerecosystem/spanner-cli) as seen below:

```
SPANNER_EMULATOR_HOST=0.0.0.0:9010 spanner-cli \
    -p $GOOGLE_PROJECT_ID \
    -i $SPANNER_INSTANCE_ID \
    -d $SPANNER_DATABASE_ID
```

## Credits

- [emulator-samples](https://github.com/cloudspannerecosystem/emulator-samples/tree/master/docker) for the inspiration

## Disclaimer

This is not an official Google product.
