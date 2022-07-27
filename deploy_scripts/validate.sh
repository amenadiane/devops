#!/usr/bin/env bash
sleep 10
# validating that the host is up on 8080
nc -zv 127.0.0.1 8080
