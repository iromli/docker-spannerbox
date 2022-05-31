# spannerbox

`spannerbox` is a set of tools to work with Spanner locally, distributed as docker image.

**WARNING!!**

`spannerbox` **MUST NOT** be used in production.

## Batteries Included

- `emulator`
- `spanner-cli`
- `spanner-dump`
- `spanner-truncate`

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

<details>
    <summary><b>NOTE</b> about <code>$VERSION</code></summary>
   <p>See <a href="https://github.com/iromli/docker-spannerbox/releases">Releases</a> for available <code>$VERSION</code>. The <code>v</code> prefix must be omitted when using tag, for example: <code>spannerbox:1.0.0</code> instead of <code>spannerbox:v1.0.0</code>.</p>
</details>

The database can be accessed using command as seen below:

```
docker exec -ti spanner spanner-cli
```

## Credits

- [emulator-samples](https://github.com/cloudspannerecosystem/emulator-samples/tree/master/docker) for the inspiration
- [spanner-cli](https://github.com/cloudspannerecosystem/spanner-cli)
- [spanner-dump](https://github.com/cloudspannerecosystem/spanner-dump)
- [spanner-truncate](https://github.com/cloudspannerecosystem/spanner-truncate)

## Disclaimer

This is not an official Google product.
