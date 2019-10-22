ROOT="https://www.bungie.net"
MANIFEST=$(curl -s -H "X-API-Key: $API_KEY" "$ROOT/Platform/Destiny2/Manifest/")

EN=$(echo $MANIFEST | jq -r .Response.jsonWorldContentPaths.en)
KO=$(echo $MANIFEST | jq -r .Response.jsonWorldContentPaths.ko)

mkdir -p data

wget -O ./data/en_raw.json "$ROOT$EN"
wget -O ./data/ko_raw.json "$ROOT$KO"

