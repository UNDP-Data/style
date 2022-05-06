import subprocess
import zipfile
import logging
import shutil
from multiprocessing import Pool
from pathlib import Path
from urllib import request

MAX_ZOOM = 10
REMOTE_URL = 'https://data.fieldmaps.io'
cwd = Path(__file__).parent
tmp = cwd / 'tmp'
outputs = cwd / 'outputs'
logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s - %(name)s - %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S')
logger = logging.getLogger(__name__)


def get_options(l, geom, geojsonl_path, tile_path):
    if geom == 'polygons':
        options = [
            'tippecanoe',
            f'--layer=adm{l}_polygons',
            f'--maximum-zoom={MAX_ZOOM}',
            '--simplify-only-low-zooms',
            '--detect-shared-borders',
            '--read-parallel',
            '--no-tile-size-limit',
            '--no-tile-compression',
            '--force',
            f'--output-to-directory={tile_path}',
            geojsonl_path,
        ]
        for x in range(0, l+1):
            if l >= x:
                options.append(f'--include=adm{x}_id')
                options.append(f'--include=adm{x}_name')
    # TODO: not finished
    elif geom == 'lines':
        options = [
            'tippecanoe',
            f'--layer=adm{l}_lines',
            f'--maximum-zoom={MAX_ZOOM}',
            '--simplify-only-low-zooms',
            '--no-simplification-of-shared-nodes',
            '--read-parallel',
            '--no-tile-size-limit',
            '--force',
            f'--include=adm{l}_line',
            f'--output-to-directory={tile_path}',
            geojsonl_path,
        ]
        for x in range(0, l):
            if l >= x:
                options.append(f'--include=adm{x}_id')
                options.append(f'--include=adm{x}_name')
    return options


def process_admin(l, geom):
    zip_path = tmp / f'adm{l}_{geom}.gpkg.zip'
    gpkg_path = tmp / f'adm{l}_{geom}.gpkg'
    geojsonl_path = tmp / f'adm{l}_{geom}.geojsonl'
    tile_path = outputs / f'adm{l}_{geom}'
    r = request.build_opener()
    r.addheaders = [('User-agent', 'Mozilla/5.0')]
    request.install_opener(r)
    if l > 0:
        url = f"{REMOTE_URL}/edge-matched/humanitarian/intl/adm{l}_{geom}.gpkg.zip"
    else:
        url = f"{REMOTE_URL}/adm0/intl/adm0_{geom}.gpkg.zip"
    request.urlretrieve(url, zip_path)
    logger.info(f'downloaded: adm{l}_{geom}')
    with zipfile.ZipFile(zip_path, 'r') as z:
        z.extractall(tmp)
    zip_path.unlink(missing_ok=True)
    logger.info(f'extracted: adm{l}_{geom}')
    subprocess.run(['ogr2ogr', geojsonl_path, gpkg_path],
                   stderr=subprocess.DEVNULL)
    logger.info(f'converted: adm{l}_{geom}')
    gpkg_path.unlink(missing_ok=True)
    options = get_options(l, geom, geojsonl_path, tile_path)
    subprocess.run(options, stderr=subprocess.DEVNULL)
    geojsonl_path.unlink(missing_ok=True)
    logger.info(f'tiled: adm{l}_{geom}')


if __name__ == '__main__':
    shutil.rmtree(tmp, ignore_errors=True)
    shutil.rmtree(outputs, ignore_errors=True)
    tmp.mkdir(parents=True, exist_ok=True)
    outputs.mkdir(parents=True, exist_ok=True)
    results = []
    pool = Pool()
    for l in range(0, 5):
        result = pool.apply_async(process_admin, args=[l, 'polygons'])
        # result = pool.apply_async(process_admin, args=[l, 'lines'])
        results.append(result)
    pool.close()
    pool.join()
    shutil.rmtree(tmp, ignore_errors=True)
