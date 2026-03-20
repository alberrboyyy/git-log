#!/bin/bash

# Dev
rm "$PWD/out/jdt.md" 2>/dev/null
[ -d "$PWD/out" ] || mkdir "$PWD/out"

###

OUTPUT="$PWD/out/jdt.md"


if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "pas de dossier git"
    exit 1
fi






declare LASTDATE

for hash in $(git rev-list HEAD); do
    CURRENTDATE=$(git show -s --format=%cd --date=format:'%d.%m.%Y' $hash)
    MSG=$(git show -s --format=%s $hash)
    
    if [ "$CURRENTDATE" != "$LASTDATE" ]; then
        LASTDATE="$CURRENTDATE"
        
        echo "" >> "$OUTPUT"
        echo "" >> "$OUTPUT"
        echo "# $CURRENTDATE" >> "$OUTPUT"
    fi
    
    git show -s --format="|  |  | %an | %s |" $hash >> "$OUTPUT"
    
done


echo "" >> "$OUTPUT"
