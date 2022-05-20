# spannerbox

`spannerbox` is an image contains pre-configured Spanner emulator.

The image includes `gcloud` to initialize config, instance, and database.

## Usage

The following environment variables can be used to customize `spannerbox` container:

- `GOOGLE_PROJECT_ID`: Google project ID (default to `test-project`)
- `GOOGLE_SPANNER_INSTANCE_ID`: Spanner instance ID (default to `test-instance`)
- `GOOGLE_SPANNER_DATABASE_ID`: Spanner Database ID (default to `test-database`)

Example of running `spannerbox` using `docker`:

```
export GOOGLE_PROJECT_ID=test-project
export GOOGLE_SPANNER_INSTANCE_ID=test-instance
export GOOGLE_SPANNER_DATABASE_ID=test-database

docker run \
    -p 9010:9010 \
    -e GOOGLE_PROJECT_ID=$GOOGLE_PROJECT_ID \
    -e GOOGLE_INSTANCE_ID=$GOOGLE_SPANNER_INSTANCE_ID \
    -e GOOGLE_DATABASE_ID=$GOOGLE_SPANNER_DATABASE_ID \
    iromli/spannerbox:$VERSION
```

**NOTE:** see [Releases](https://github.com/iromli/docker-spannerbox/releases) for available `$VERSION`.

The database can be accessed using [spanner-cli](https://github.com/cloudspannerecosystem/spanner-cli) as seen below:

```
SPANNER_EMULATOR_HOST=0.0.0.0:9010 spanner-cli \
    -p $GOOGLE_PROJECT_ID \
    -i $GOOGLE_SPANNER_INSTANCE_ID \
    -d $GOOGLE_SPANNER_DATABASE_ID
```

## Credits

- [emulator-samples](https://github.com/cloudspannerecosystem/emulator-samples/tree/master/docker) for the inspiration

## Disclaimer

This is not an official Google product.
