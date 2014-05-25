#!/bin/bash

# the the hostname of the first running AWS instance of the given environment
# TODO pass this in
AWS_ENV=testing

hostnames=$(aws ec2 describe-instances \
  --filters "Name=tag:environment,Values=$AWS_ENV" \
  --query 'Reservations[*].[Instances[0].State.Name,Instances[0].PublicDnsName]' \
  --output text  | awk '{print $2}')
  # --output text  | grep running | awk '{print $2}' \

# just print the first one
first_hostname=$(echo $hostnames | awk '{print $1}')

# and only if there is a value
if [ -n "$first_hostname" ]; then
  echo $first_hostname
fi

