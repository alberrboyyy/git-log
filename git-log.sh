#!/bin/bash

# Dev
rm "$PWD/out/jdt.md" 2>/dev/null
[ -d "$PWD/out" ] || mkdir "$PWD/out"

###

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Erreur : Ce dossier n'est pas un dépôt Git."
    exit 1
fi



OUTPUT="$PWD/out/jdt.md"

git log --date=format:'%d.%m.%Y' --pretty=format:"- %cd | \`%h\` - %an : %s" >> "$OUTPUT"

echo "" >> "$OUTPUT"
echo "succes"