#!/bin/sh

# Can't find the build tool? Best do nothing
if ! command -v cobalt > /dev/null; then
    exit 1
fi

# Clean
if [ -d "_site" ]; then
    echo "Clean..."
    rm -rf "_site"
fi

# Build
echo "Build..."
cobalt build

# Link for rss feed to preserve old permalink
if [ -f "_site/feed.xml" ]; then
    ln -s "feed.xml" "_site/rss.xml"
fi

# Minify ALL THE THINGS!
if ! command -v minify > /dev/null; then
    exit 1
fi

if [ ! -d "_site" ]; then
    exit 1
fi

echo "Minify..."
minify -o _site/ -r _site/
