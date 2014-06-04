#!/bin/bash

AWS_ENV=${1:-testing}

hostname_string=$(aws ec2 describe-instances \
  --filters "Name=tag:environment,Values=$AWS_ENV" \
  --query 'Reservations[*].[Instances[0].State.Name,Instances[0].PublicDnsName]' \
  --output text  | grep running | awk '{print $2}')

declare -a hostnames=( $hostname_string )

echo "Finding instances from the $AWS_ENV environment"

for hostname in ${hostnames[@]} ; do
  printf "${hostname}\n"
done

