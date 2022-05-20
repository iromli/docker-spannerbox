# spannerbox

`spannerbox` is an image contains pre-configured Spanner emulator (with batteries included).

## Batteries Included

- emulator to bootstrap instance and database
- CLI to interact with database

## Usage

The following environment variables can be used to customize `spannerbox` container:

- `SPANNER_PROJECT_ID`: Google project ID (default to `test-project`)
- `SPANNER_INSTANCE_ID`: Spanner instance ID (default to `test-instance`)
- `SPANNER_DATABASE_ID`: Spanner Database ID (default to `test-database`)

Example of running `spannerbox` using `docker`:

```
export SPANNER_PROJECT_ID=test-project
export SPANNER_INSTANCE_ID=test-instance
export SPANNER_DATABASE_ID=test-database

docker run \
    -p 9010:9010 \
    --name spanner \
    -e SPANNER_PROJECT_ID=$SPANNER_PROJECT_ID \
    -e SPANNER_INSTANCE_ID=$SPANNER_INSTANCE_ID \
    -e SPANNER_DATABASE_ID=$SPANNER_DATABASE_ID \
    iromli/spannerbox:$VERSION emulator
```

**NOTE:** see [Releases](https://github.com/iromli/docker-spannerbox/releases) for available `$VERSION`.

The database can be accessed using command as seen below:

```
docker exec -ti spanner cli
```

## Credits

- [emulator-samples](https://github.com/cloudspannerecosystem/emulator-samples/tree/master/docker) for the inspiration
- [spanner-cli](https://github.com/cloudspannerecosystem/spanner-cli) for the CLI access

## Disclaimer

This is not an official Google product.
