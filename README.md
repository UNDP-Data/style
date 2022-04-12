# style

This repository is to manage the style.json for base map of geohub

## prepare

```bash
$npm i
```

## initial import carto style.json

```bash
$curl https://tiles.basemaps.cartocdn.com/gl/voyager-gl-style/style.json | $charites convert - style.yml
```

## build style.yml

```bash
$npm run build
```

## preview style.yml

```bash
$charites serve style.yml
```

## create sprite


```
npm run spritezero sprite maki-icons/ --retina --ratio=2 --sdf
```

## License

The license of style belong to CARTO. See [License](./LICENSE).

The license of source code is MIT license.
