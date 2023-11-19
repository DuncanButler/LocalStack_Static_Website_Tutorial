# Demo of Terraform in LocalStack

## Introduction

built using the LocalStack Tutorial on page [S3 Static Website Terraform](https://docs.localstack.cloud/tutorials/s3-static-website-terraform/) 

## Prerequisites

In order to follow the tutorial successfully the following dependencies need to be installed and setup.

- [Docker](https://www.docker.com/) installed and registered
- [LocalStack](https://localstack.cloud) installed and registered
- [Terraform](https://www.terraform.io/) installed and available from the command line
- [Python and Pip](https://www.python.org/) installed and configured, used by the AWS command line as well as terraform local tooling
- Terraform Local run the command `$ pip install terraform-local`
 
## Terraform
All the terraform files that create the required infrastructure are stored in the infrastructure folder.
- [provider.tf](infrastructure%2Fprovider.tf) defines which cloud we are going to be using for terraform, and some additional parameters that are required to use the local stack instances. when using the TFLocal command line this file is not required so has been omitted from the project source its contents are below, so the terraform files can be run against and aws account without change. 
```
  provider "aws" {
     region = "us-east-1"
     access_key = "test"
     secret_key = "test"

     # only required for non virtual hosted-style endpoint use case.
     # https://registry.terraform.io/providers/hashicorp/aws/latest/docs#s3_force_path_style
     s3_use_path_style = false
     skip_credentials_validation = true
     skip_metadata_api_check = true
     skip_requesting_account_id = true

     endpoints {
       s3 = "http://s3.localhost.localstack.cloud:4566"
     }
  }
 ```
- [variables.tf](infrastructure%2Fvariables.tf) defines all the variables we are going to use in the terraform scripts.

- [outputs.tf](infrastructure%2Foutputs.tf) defines all the outputs from the terraform scripts

- [main.tf](infrastructure%2Fmain.tf) the core file that creates the infrastructure 

once complete the test website will be available at `https://[bucket-name].s3-website.localhost.localstack.cloud:4566/`

## Structurizr 

To run the documentation portal in your local web browser ensure that the docker engine is running on the local machine

### Windows

from the infrastructure folder run the following powershell script `$ ./RunStructurizr.ps1` this will download the lastest Structurizr docker container and run the workspace model and documentation, makeing both available to explore on (localhost:8080)[http://localhost:8080]

### Mac / linux

from the command line run `$ docker pull structurizr/lite` to download the docker container, then run the command line replacing the local path with the location of the architecture folder on your local machine
```
$ docker run -it --rm -p 8080:8080 -v <full path to architecture directory>:/usr/local/structurizr structurizr/lite
```
this will run the structurizr docker container with the workspace and documentation making them both available to explore on [localhost:8080](http://localhost:8080).
