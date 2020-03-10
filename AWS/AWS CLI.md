# AWS CLI Examples

Upgrade to the latest aws version

``` bash
aws --version
sudo pip install --upgrade awscli
```

To configure your user onto the e2c
``` bash
aws configure
``` 

To describe regions

``` bash
aws ec2 describe-regions
```

To get help with aws cli 

- https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-regions.html
- aws help

As you can see, in the aws help command there are many services available. Thus, the AWS CLI makes use of a common pattern for working with each service: aws <service> <command>. For example, aws ec2 describe-regions. 

Follow the AWS CLI service pattern to get help on commands available for the EC2 service: 

``` bash
aws ec2 help
```

Get the help page for a specific command:

``` bash
aws ec2 describe-regions help
```

Help pages for service commands provide additional sections for how to use the command:

- SYNOPSIS: Shows the usage of the command
- OPTIONS: Describes the options/arguments you can provide on the command-line - to modify the behavior of the command
- EXAMPLES: Provides sample commands along with a text description of what the - command accomplishes and the output the command produces
- OUTPUT: Describes the format of the output of the command

Recall earlier that you defined text as your default output, so all the commands that support text output should return text. However, you can specify the desired output when entering a command by appending --output <type>.

Display the output in differnt formats:

``` bash
aws ec2 describe-regions --output json
aws ec2 describe-regions --output table
aws ec2 describe-regions --output text
```

Because you configured text as the default output format, you can omit the --output option and achieve the same result.

Describe the VPCs in the default region us-west-2:

``` bash
aws ec2 describe-vpcs --output json
```

Specify a different region by appending --region <region name>:

``` bash
aws ec2 describe-vpcs --region us-east-1
```