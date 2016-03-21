#!/bin/bash

# Create a single GeoJSON tile
#
# usage:  make_tile.sh latmin lonmin latmax lonmax output
#

LLAT=$1
LLON=$2
ULAT=$3
ULON=$4
ACC=$5

OUT=$6

if [ -f "${OUT}" ]; then
    echo "ERROR: Output file exists"
    exit -1;
fi



# tile is lat/lon
TILE="ST_PolygonFromText( 'POLYGON(( $LLON $ULAT, $LLON $LLAT, $ULON $LLAT, $ULON $ULAT, $LLON $ULAT ))', 4326)"

# buurtsmall table is in 4326
SQL="""
WITH task AS (
SELECT ${TILE} AS tile
)
SELECT bu_naam,urban,inw,green,water,round(uhi50p * 100) as uhi50p, round(uhi95p * 100) as uhi95p, geom AS geom
FROM buurtsmall, task
WHERE ST_Intersects( ST_Centroid(geom), tile )
AND bu_naam IS NOT NULL
"""
# output is in lat/lon 4326


echo "Generating $OUT"
rm -f "$OUT"
ogr2ogr -f GeoJSON "$OUT" PG:"dbname=jiska user=jiska host=localhost password={fill in password}" -sql "${SQL}"

if [ 131 == `cat "$OUT" | wc -c` ]; then
    echo "Tile is emtpy, removing it"
    rm "$OUT"
else
    T=`cat "$OUT" | json_reformat -m`
    echo "$T" >  "$OUT"
fi

