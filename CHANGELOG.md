# Changelog

## [1.1.0](https://github.com/iromli/docker-spannerbox/compare/v1.0.2...v1.1.0) (2024-05-19)


### build

* add labels to automate local build script ([36b7cfa](https://github.com/iromli/docker-spannerbox/commit/36b7cfaf36f986226162446c91376e18fdd33237))


### Features

* bump version of included components ([9c0df78](https://github.com/iromli/docker-spannerbox/commit/9c0df787f1c046af1d29ba88304da923c3318921))

## [1.0.2](https://github.com/iromli/docker-spannerbox/compare/v1.0.1...v1.0.2) (2023-06-30)


### Bug Fixes

* missing emulator_main and gateway_main binaries ([28361ca](https://github.com/iromli/docker-spannerbox/commit/28361ca4f625911e49a7d02e0edb36ed5dc42fab))

## [1.0.1](https://github.com/iromli/docker-spannerbox/compare/v1.0.0...v1.0.1) (2023-02-22)


### Bug Fixes

* update binaries location to copy from ([367c526](https://github.com/iromli/docker-spannerbox/commit/367c526c4628ce4d17c72fecb56f643149eca5a1))

## [1.0.0](https://github.com/iromli/docker-spannerbox/compare/v1.0.0-alpha.3...v1.0.0) (2022-11-06)


### Features

* upgrade spanner-cli and spanner-truncate version ([c46ae4c](https://github.com/iromli/docker-spannerbox/commit/c46ae4ccb3bd447df5c83f605553d363212fed5f))


### build

* bump version ([7a0b183](https://github.com/iromli/docker-spannerbox/commit/7a0b183105aea400d6b7651b5c3ca0ac38db77b4))

## [1.0.0-alpha.3](https://github.com/iromli/docker-spannerbox/compare/v1.0.0-alpha.2...v1.0.0-alpha.3) (2022-05-31)


### Features

* add spanner-truncate ([631e130](https://github.com/iromli/docker-spannerbox/commit/631e13025be6727473fe474fb2ccac43d1d882f5))


### build

* bump version ([f73ceb2](https://github.com/iromli/docker-spannerbox/commit/f73ceb2740f61b5380037b0b0317f95744c3b36f))

## [1.0.0-alpha.2](https://github.com/iromli/docker-spannerbox/compare/v1.0.0-alpha.1...v1.0.0-alpha.2) (2022-05-27)


### Features

* add dump command to export database into text format ([99f853b](https://github.com/iromli/docker-spannerbox/commit/99f853b178198241522fc0ffaccfde3c12b51b31))

## 1.0.0-alpha.1 (2022-05-21)


### Features

* add env vars to customize running container ([c94593b](https://github.com/iromli/docker-spannerbox/commit/c94593b714424f91a35048e8e98ec046e0e01236))
* add image manifests ([74aa68c](https://github.com/iromli/docker-spannerbox/commit/74aa68c898cb55811b0723472ba385dcd78f9447))
* introduce commands to work with spanner ([8c50f1a](https://github.com/iromli/docker-spannerbox/commit/8c50f1ab04c304bd45b74bd57ff629cf1d06745a))
* remove gcloud in favor of direct cURL to configure spanner ([312ee65](https://github.com/iromli/docker-spannerbox/commit/312ee6555259b1de515b5c26fdbd2bcd7a78253b))


### Bug Fixes

* set hashbang to bash ([2d904cc](https://github.com/iromli/docker-spannerbox/commit/2d904ccaaacffbc14f7b109bad4423791f860c45))


### Continuous Integration

* rename workflow file build_image.yml to build.yml ([6dbb5dd](https://github.com/iromli/docker-spannerbox/commit/6dbb5ddf5462bd01f7497e13d5e0860a1bef9dbe))
