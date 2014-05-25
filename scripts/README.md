
#### Instructions

The `aws_hostname.sh` and `ssh_aws.sh` scripts should be put into the `$PATH`.
I also used symlinks to drop the `.sh`.

If you're doing this then you also need to edit `ssh_aws.sh` changing this
line:

```
hostname=$(./aws_hostname.sh)
```

To:

```
hostname=$(aws_hostname.sh)
```

#### TODO

At the moment these are fairly limited in use scripts (they only solve a
specific problem I have).

Plans for improvements include:

1.  Pass in the `AWS_ENV` value  
    Currently hardcoded to `testing`.
1.  Pass in the `EC2_INSTANCE_USER` value  
    Currently hardcoded to `ubuntu` since my instances are Ubuntu (but note
    this would be `admin` for Debian).
1.  Present a list of running instances to allow the user to choose the one
    they want.
