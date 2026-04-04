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

# ask for who to make the log
author=$(git shortlog -sn | awk '{ $1=""; print $0 }' | sed 's/^[ ]*//' | fzf --prompt=" > ")



declare lastdate

for hash in $(git rev-list --reverse --author=$author HEAD); do
    currentdate=$(git show -s --format=%cd --date=format:'%d.%m.%Y' $hash)
    msg=$(git show -s --format=%s $hash)
    time=$(git show -s --format="%(trailers:key=Time,valueonly)" $hash | tr -d '\n')
    status=$(git show -s --format="%(trailers:key=Status,valueonly)" $hash | tr -d '\n')

    if [ "$currentdate" != "$lastdate" ]; then
        lastdate="$currentdate"

        echo "" >> "$OUTPUT"
        echo "" >> "$OUTPUT"
        echo "# $currentdate" >> "$OUTPUT"
        echo "| Status | Time | Message |" >> "$OUTPUT"
        echo "| --- | --- | --- |" >> "$OUTPUT"
    fi

    git show -s --format="| $status | $time | %s |" $hash >> "$OUTPUT"

done


echo "" >> "$OUTPUT"
