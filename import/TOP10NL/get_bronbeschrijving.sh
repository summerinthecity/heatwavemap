#!/bin/bash

for t in             \
functioneelgebied    \
gebouw               \
geografischgebied    \
hoogteofdieptepunt   \
hoogteverschil       \
inrichtingselement   \
isohoogte            \
kadeofwal            \
registratiefgebied   \
spoorbaandeel        \
terrein              \
waterdeel            \
wegdeel            ; \
do
    echo "select distinct bronbeschrijving from $t ;" | psql | tail -n +3 | head -n +1
done

