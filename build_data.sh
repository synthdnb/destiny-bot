#!/bin/bash
read -r -d '' QUERY << EOF
[.DestinyInventoryItemDefinition |
values[] |
select(.itemType == 3) | 
{
    name: .displayProperties.name,
    desc: .displayProperties.description,
    icon: .displayProperties.icon,
    typeAndTierName: .itemTypeAndTierDisplayName,
    tierType: .inventory.tierType,
    index: .index,
    hash: .hash
}]
EOF

jq -r "$QUERY" ./data/en_raw.json > ./data/en.json
jq -r "$QUERY" ./data/ko_raw.json > ./data/ko.json
