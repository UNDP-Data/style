# @undp-data/style

This repository is to manage the style.json for base map of geohub

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
