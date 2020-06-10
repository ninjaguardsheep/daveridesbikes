#!/bin/sh

if ! command -v cobalt > /dev/null; then
    exit 1
fi

if [ -d "_site" ]; then
    rm -rf "_site"
fi

cobalt build

if [ -f "_site/feed.xml" ]; then
    ln -s "feed.xml" "_site/rss.xml"
fi
