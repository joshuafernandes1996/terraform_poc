# main_Infrastructure

# Terraform Script to Boostrap the instances and environment required to run the Website

Config:

- Two instances launch in a VPC (Virtual Private Cloud)
    - 1 Instance for WebServer which runs in a Public Subnet through a NAT Gateway
    - 1 Instance for Database which runs in a Private Subnet with internet access through a NAT Gateway
- VPC
    - Created a VPC Specially for the two
    - 2 Public Subnets and 1 Private
    - Access to Internet it through A NAT Gateway, configured with route table and association with the subnets
- Security Groups
    - 3 Security Groups
    - For
        - Instances to allow ssh, TCP connections on port 80, 443, 0-65535
        - Database for port 3306
        - and Load Balancer with ports same as instances with forwarding rule
- Keypair
    - Instances are launch using private and public key, using ssh-keygen
    - Command `ssh-keygen -f <key_name>`
- S3
    - Created and provisioned an S3 bucket to store static data
- Provisioner 
    - A script is written to provision all necessary dependancies on the servers to run the project
- ALB
    - Application Load Balancer between the two subnets
    - Listens to port assigned and forwards to the Instance



Note: Create a terraform.tfvars file with your AWS Credentials as below
terraform.tfvars
AWS_ACCESS_KEY = <AWS_ACCESS_KEY>
AWS_SECRET_KEY = <AWS_SECRET_KEY>