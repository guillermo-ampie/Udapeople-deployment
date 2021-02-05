#!/bin/sh

S3_BUCKET_NAME="9c2e11322879b3"
S3_STACK_FILE="bucket.yml"
CLOUDFRONT_STACK_FILE="cloudfront.yml"
STACK_NAME="production-distro"
TAGS="project=udapeople"


if aws cloudformation validate-template --template-body file://${CLOUDFRONT_STACK_FILE} >/dev/null
then
    echo "Deploying stack: ${STACK_NAME}..."
    aws cloudformation deploy \
        --template-file ${CLOUDFRONT_STACK_FILE} \
        --stack-name "stack-${STACK_NAME}" \
        --parameter-overrides WorkflowID=${S3_BUCKET_NAME} \
        --tags ${TAGS}
else
    echo
     echo ">>> The template [${CLOUDFRONT_STACK_FILE}] has some errors, process aborted!!! <<<"
    echo   
fi
