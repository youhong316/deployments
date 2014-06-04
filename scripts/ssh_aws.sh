#!/bin/bash

AWS_ENV=${1:-testing}
EC2_INSTANCE_USER=${2:-ubuntu}

hostnames_string=$(aws ec2 describe-instances \
  --filters "Name=tag:environment,Values=$AWS_ENV" \
  --query 'Reservations[*].[Instances[0].State.Name,Instances[0].PublicDnsName]' \
  --output text  | grep running | awk '{print $2}')

declare -a hostnames=( $hostnames_string )

# I was getting this from a separate script but it seems more practical to keep
# this as standalone.
# declare -a hostnames=$(./aws_hostname.sh $AWS_ENV)

echo "Finding instances from the $AWS_ENV environment"

# and only if there is a value
if [ -n "$hostnames" ]; then

  if [ "${#hostnames[@]}" -eq 1 ] ; then
    ssh $EC2_INSTANCE_USER@${hostnames[0]}
  fi

  if [ "${#hostnames[@]}" -gt 1 ] ; then
    PS3="Type a number or 'q' to quit: "

    select hostname in ${hostnames[@]} ; do
      if [ -n "$hostname" ]; then
          ssh $EC2_INSTANCE_USER@${hostname}
      fi
      break
    done
  fi

else
  echo "No running instance."
fi

