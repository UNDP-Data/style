---
"@undp-data/style": patch
---

fix: added terrarium-hillshade only for hillshade layer since maplibre complains if both hillshade and terrain use the same raster-dem source.
