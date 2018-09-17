#!/usr/bin/env bash

targets_ip=".targets_ip"

sed "/^#/d" $targets_ip | awk '{print "alias ssh"$1"=\"ssh "$3"@"$4"\""}'
