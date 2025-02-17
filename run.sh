#!/bin/sh

set -e

rm -f /data/data.db

litestream restore -if-replica-exists /data/data.db

litestream replicate -exec 'npmrun docker:start'
