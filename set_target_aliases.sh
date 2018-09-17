#!/usr/bin/env bash

targets_ip=".targets_ip"

mkdir -p ~/.config;

sed "/^#/d" $targets_ip | awk '{print "alias ssh"$1"=\"ssh "$3"@"$4"\""}' | tee ~/.config/targets_alias

echo ""
echo "Make sure to add source ~/.config/targets_alias in your bashrc or zshrc"
