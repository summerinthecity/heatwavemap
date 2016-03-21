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
    pg_dump -t $t --schema-only
done

