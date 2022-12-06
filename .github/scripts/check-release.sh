#!/bin/sh

# Checking if current tag matches the package version
current_tag=$(echo $GITHUB_REF | cut -d '/' -f 3 | sed -r 's/^v//')
file1='package.json'
file2='src/lib/version.js'

file_tag1=$(grep '"version":' $file1 | cut -d ':' -f 2- | tr -d ' ' | tr -d '"' | tr -d ',')
file_tag2=$(grep 'export' $file2 | cut -d ' ' -f 3- | tr -d ';' | tr -d "'")
if [ "$current_tag" != "$file_tag1" ] || [ "$current_tag" != "$file_tag2" ]; then
  echo "Error: the current tag does not match the version in package file(s)."
  echo "$file1: found $file_tag1 - expected $current_tag"
  echo "$file2: found $file_tag2 - expected $current_tag"
  exit 1
fi

echo 'OK'
exit 0
