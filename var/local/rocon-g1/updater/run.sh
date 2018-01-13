#!/bin/sh
export PATH=$PATH:/usr/bin:/usr/local/bin
export NODE_PATH="/usr/local/lib/node_modules:/usr/local/node_modules"
cd $(dirname $0)
pwd
node runme.js