# @undp-data/style

This repository is to manage the style.json for base map of geohub

## Usage

### Maplibre style.json

Check the latest version of `@undp-data/style` package at [npmjs](https://www.npmjs.com/package/@undp-data/style?activeTab=versions), and replace the version of `0.0.1` to the latest one. Or, you may use `latest` to fetch style.json from CDN. But we strongly recommend to specify the version to prevent any breaking change error on style.json.

- OSM style

```
https://unpkg.com/@undp-data/style@0.0.1/dist/style.json
```

- Bing aerial style

```
https://unpkg.com/@undp-data/style@0.0.1/dist/aerialstyle.json
```

### Sprite

- SDF

```
https://unpkg.com/@undp-data/style@latest/dist/sprite/sprite
```

- Non SDF

```
https://unpkg.com/@undp-data/style@latest/dist/sprite-non-sdf/sprite
```


## Install

```shell
pnpm i
```

### M1 Mac

If you are using M1 Mac, sprite-zero cannot be installed in normal nodejs, so please install nodejs by using NVM as following commands.

```shell
$nvm uninstall 18
$arch -x86_64 zsh
$nvm install 18
$nvm alias default 18
```

## Build style.json

```shell
pnpm build:style
pnpm build:aerialstyle
```

## Develop style.json

- launch preview for OSM style

```shell
pnpm serve
```

- launch preview for Bing aerial style

```shell
pnpm serve:aerial
```

## Build sprite

```shell
pnpm build:sprite
```

## Release map style

The procedure for releasing map style to NPM is as follows.

- create release note by the following command `pnpm changeset`.
- create new PR to merge to main branch.
- changeset will create new PR to release packages.
- changeset will release packages once the PR is merged to main.

## License

The license of style belong to CARTO. See [License](./LICENSE).

The license of source code is MIT license.
