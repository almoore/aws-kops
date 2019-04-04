# Kops Setup #

This is largely taken from information given in these documents:

- Kubernetes.io Setup guide: [Installing Kubernetes on AWS with kops](https://kubernetes.io/docs/setup/custom-cloud/kops/)
- The kops github repo [AWS Getting Started](https://github.com/kubernetes/kops/blob/master/docs/aws.md)
- The kops github repo [Building Kubernetes clusters with Terraform](https://github.com/kubernetes/kops/blob/master/docs/terraform.md)

The steps taken to setup the kops directory are in the file [kops/setup.sh](kops/setup.sh)

The main things that were done are as follows.

- Setup a subdomain
- Run `terraform init` for backend state data
- Run `kops create cluster` with the correct arguments

## Setup a subdomain under a domain purchased/hosted via AWS ##

The subdomain kubernetes.aws.empoweredtechnology.net was setup under aws.empoweredtechnology.net and the subdomain NS records were applied to the PARENT hosted zone.

## Set up remote state ##

The only terraform file added to the kops directory by hand was the [backend.tf](kops/backend.tf) file for storing the terraform state data.

The rest of the `*.tf` files were added by the kops tool.

Note: It is NOT possible to have multiple kops configurations in the same directory.

## Editing the cluster ##

It's possible to use Terraform to make changes to your infrastructure as defined by kops. In the example below we'd like to change some cluster configs:

```bash
$ kops edit cluster \
  --name=kubernetes.aws.empoweredtechnology.net  \
  --state=s3://terraform-tfstate-data

# editor opens, make your changes ...
```

Then output your changes/edits to kops cluster state into the Terraform files. Run kops update with --target and --out parameters:

```bash
$ kops update cluster \
  --name=kubernetes.aws.empoweredtechnology.net  \
  --state=s3://terraform-tfstate-data \
  --out=. \
  --target=terraform
```

## Deleting a cluster ##

To just remove the AWS resources.

```bash
terraform plan -destroy
terraform destroy
```

To also remove the kops configuration data.

```bash
kops delete cluster --yes \
  --name=kubernetes.aws.empoweredtechnology.net \
  --state=s3://terraform-tfstate-data
```

Ps: You don't have to kops delete cluster if you just want to recreate from scratch. Deleting kops cluster state means that you'll have to kops create again.