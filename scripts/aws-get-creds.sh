if [ ! -f access-key.json ]; then
    aws iam create-access-key --user-name kops;
fi

jq '.AccessKey.UserName'        access-key.json -r | xargs -I {} echo "[{}]" >> ~/.aws/credentials
jq '.AccessKey.AccessKeyId'     access-key.json -r | xargs -I {} echo "aws_access_key_id = {}" >> ~/.aws/credentials
jq '.AccessKey.SecretAccessKey' access-key.json -r | xargs -I {} echo "aws_secret_access_key = {}" >> ~/.aws/credentials