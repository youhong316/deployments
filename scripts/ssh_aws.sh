#!/bin/bash

# TODO pass this in
EC2_INSTANCE_USER=ubuntu

hostname=$(./aws_hostname.sh)

# and only if there is a value
if [ -n "$hostname" ]; then
  ssh $EC2_INSTANCE_USER@$hostname
else
  echo "No running instance."
fi

