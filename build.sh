#!/bin/sh
docker build . -t reverse-proxy --build-arg CACHEBUST=$(date +%s)
