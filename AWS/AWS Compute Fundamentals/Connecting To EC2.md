# Connecting to EC2

This can be done with putty and ssh; these examples uses ssh

``` bash
ssh -i /path/to/your/keypair.pem user@server-ip
```

- server-ip is the Public IP of your server, found on the Description tab of the running instance in the EC2 Console
- user is the remote system user that will be used for the remote authentication
  -  ec2-user for Amazon Linux and RedHat
  -  admin for Debian
  -  ubuntu for ubuntu

Your SSH client may refuse to start the connection, warning that the key file is unprotected. You should deny the file access to any other system users by changing its permissions

``` bash
chmod 600  ~/keypair.pem
```

The Instances page provides a helpful shortcut for connecting to a Linux instance. Select the running instance and click the Connect button. It will formulate an example ssh command for you, including the required key name and public IP address. However, it is still useful to learn the basics of manually using the ssh command.


# Listing EC2 Metadata

List all instance metadata by issuing the following command:

```bash
curl -w "\n" http://169.254.169.254/latest/meta-data/
```

Note: The IP address used below (169.254.169.254) is a special use address to return metadata information tied to EC2 instances. The following options are returned:

- ami-id
- ami-launch-index
- ami-manifest-path
- block-device-mapping/
- events/
- hostname
- identity-credentials/
- instance-action
- instance-id
- instance-type
- local-hostname
- local-ipv4
- mac
- metrics/
- network/
- placement/
- profile
- public-hostname
- public-ipv4
- public-keys/
- reservation-id
- security-groups
- services/

Enter the following commands to extract specific metadata associated with your running instance: 

```
curl -w "\n" http://169.254.169.254/latest/meta-data/security-groups
curl -w "\n" http://169.254.169.254/latest/meta-data/ami-id
curl -w "\n" http://169.254.169.254/latest/meta-data/hostname
curl -w "\n" http://169.254.169.254/latest/meta-data/instance-id
curl -w "\n" http://169.254.169.254/latest/meta-data/instance-type
```

Enter the following command to get the public SSH key of the attached key pair using the public-keys metadata:

``` bash
curl -w "\n" http://169.254.169.254/latest/meta-data/public-keys/0/openssh-key
```