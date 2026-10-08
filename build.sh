#!/usr/bin/env bash
# Render build for nuvogroup.co: unpack the generated site and fetch Pexels photos.
set -euo pipefail
rm -rf ./dist
mkdir -p ./dist
tar -xzf site.tar.gz -C ./dist
while read -r path url; do
  [ -z "${path:-}" ] && continue
  curl -fsSL --retry 3 "$url" -o "./dist/$path"
done < ./dist/remote-images.txt
rm -f ./dist/remote-images.txt
echo "Built $(find ./dist -name '*.html' | wc -l) pages"
