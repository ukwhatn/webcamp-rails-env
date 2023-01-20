#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd /environment/app

rm -rf /environment/app/tmp/pids/server.pid

ls -la
pwd

rails s -b 0.0.0.0
