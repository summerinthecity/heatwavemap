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

# gemeente table is in RD/New 28992
SQL="""
WITH task AS (
SELECT ST_Transform( ${TILE}, 28992 ) AS tile
)
SELECT 
       gm_naam                                         AS naam,
       aant_inw / opp_tot                              AS bevolkingsdichtheid,
       image                                           AS image,
       ST_Transform(ST_Simplify(geom, ${ACC} ), 4326 ) AS geom
FROM gemeente, task
WHERE ST_Intersects( ST_Centroid(geom), tile )
AND gm_naam IS NOT NULL
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

