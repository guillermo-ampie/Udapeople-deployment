#!/bin/sh

S3_BUCKET_NAME="9c2e11322879b3"
S3_STACK_FILE="bucket.yml"
CLOUDFRONT_STACK_FILE="cloudfront.yml"
STACK_NAME="production-distro"
TAGS="project=udapeople"


echo "Building first deployment..."

if aws cloudformation validate-template --template-body file://${S3_STACK_FILE} >/dev/null
then
    echo "Creating bucket: ${S3_BUCKET_NAME}..."
    aws cloudformation deploy \
        --template-file bucket.yml \
        --stack-name "stack-udapeople-${S3_BUCKET_NAME}" \
        --parameter-overrides BUCKETNAME="udapeople-${S3_BUCKET_NAME}" \
        --tags ${TAGS}
else
    echo
    echo ">>> The template [${S3_STACK_FILE}] has some errors, process aborted!!! <<<"
    echo
fi 

echo "Copying index.html file to bucket: S3://udapeople-${S3_BUCKET_NAME}"
aws s3 cp index.html s3://"udapeople-${S3_BUCKET_NAME}"

