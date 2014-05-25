Some useful commands for the AWS-CLI tool.

Conveniently grabs the state of all instances and their public hostname if
they're running:

```
aws ec2 describe-instances \
  --query 'Reservations[*].[Instances[0].State.Name,Instances[0].PublicDnsName]' \
  --output text
```

Same but filtering on a tag value:

```
aws ec2 describe-instances \
  --filters 'Name=tag:Name,Values=Test*' \
  --query 'Reservations[*].[Instances[0].State.Name,Instances[0].PublicDnsName]' \
  --output text
```

And finally with grep/awk to grab the hostname so I can ssh into it:

```
aws ec2 describe-instances \
  --filters 'Name=tag:environment,Values=testing' \
  --query 'Reservations[*].[Instances[0].State.Name,Instances[0].PublicDnsName]' \
  --output text  | grep running | awk '{print $2}'
```
