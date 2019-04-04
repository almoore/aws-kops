#!/usr/bin/env bash
set -e
#set -x

export KOPS_STATE_STORE=s3://terraform-tfstate-data
export CLUSTER_NAME=kubernetes.aws.empoweredtechnology.net
export ZONES="us-east-1a,us-east-1d,us-east-1b,us-east-1c"
export PARENT_DOMAIN_NAME=aws.empoweredtechnology.net

aws route53 list-hosted-zones | jq '.HostedZones[]'

ID=$(aws route53 list-hosted-zones | jq '.HostedZones[] | select(.Name=="'$CLUSTER_NAME'.") | .Id' -r)
if [ ! -z "$ID" ]; then
  echo "Found hosted zone with id=$ID"
else
  REF=$(uuidgen)
  echo "Creating hosted zone..."
  aws route53 create-hosted-zone --name $CLUSTER_NAME --caller-reference $REF | jq .DelegationSet.NameServers
fi

# Only run if subdomain.json is not present
if [ ! -f subdomain.json ]; then 
cat << EOF | jq . > subdomain.json
{
  "Comment": "Create a subdomain NS record in the parent domain",
  "Changes": [
    {
      "Action": "CREATE",
      "ResourceRecordSet": {
        "Name": "$CLUSTER_NAME",
        "Type": "NS",
        "TTL": 300,
        "ResourceRecords": $(aws route53 get-hosted-zone --id $ID | jq '.DelegationSet.NameServers | map({ Value: . })')
      }
    }
  ]
}
EOF

PARENT_ID=$(aws route53 list-hosted-zones | jq '.HostedZones[] | select(.Name=="'$PARENT_DOMAIN_NAME'.") | .Id' -r)

aws route53 change-resource-record-sets --hosted-zone-id $PARENT_ID --change-batch file://subdomain.json
fi

export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)

terraform init
kops create cluster --dns-zone=$CLUSTER_NAME --state=$KOPS_STATE_STORE --cloud aws --zones=$ZONES --name=$CLUSTER_NAME --out=. --target=terraform

terraform init
terraform plan -out=terraform.plan
echo 'If statisfied with the output, you can now run "terraform apply --auto-approve terraform.plan"'