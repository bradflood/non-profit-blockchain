#!/bin/bash

# Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
# 
# Licensed under the Apache License, Version 2.0 (the "License").
# You may not use this file except in compliance with the License.
# A copy of the License is located at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# or in the "license" file accompanying this file. This file is distributed 
# on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either 
# express or implied. See the License for the specific language governing 
# permissions and limitations under the License.



echo Pre-requisities
echo installing jq
sudo yum -y install jq

echo Downloading and installing model file for new service
cd ~
aws s3 cp s3://us-east-1.managedblockchain-preview/etc/service-2.json .
aws configure add-model --service-model file://service-2.json

token=$(uuidgen)
echo Creating Fabric network $NETWORKNAME
echo Executing command: aws managedblockchain create-network --region $REGION \
    --client-request-token $token \
    --name "${NETWORKNAME}" \
    --description "Byzantine Flu (US) Fabric network" \
    --framework "HYPERLEDGER_FABRIC" \
    --framework-version "${NETWORKVERSION}" \
    --voting-policy "ApprovalThresholdPolicy={ThresholdPercentage=20,ProposalDurationInHours=24,ThresholdComparator=GREATER_THAN}" \
    --framework-configuration 'Fabric={Edition=STARTER}' \
    --member-configuration "Name=\"${MEMBERNAME}\",Description=\"Byzantine Flu (US) Fabric member\",FrameworkConfiguration={Fabric={AdminUsername=${ADMINUSER},AdminPassword=${ADMINPWD}}}"

aws managedblockchain create-network --region $REGION \
    --client-request-token $token \
    --name ${NETWORKNAME} \
    --description "Byzantine Flu (US) Fabric network" \
    --framework HYPERLEDGER_FABRIC \
    --framework-version ${NETWORKVERSION} \
    --voting-policy "ApprovalThresholdPolicy={ThresholdPercentage=20,ProposalDurationInHours=24,ThresholdComparator=GREATER_THAN}" \
    --framework-configuration 'Fabric={Edition=STARTER}' \
    --member-configuration "Name=\"${MEMBERNAME}\",Description=\"Byzantine Flu (US) Fabric member\",FrameworkConfiguration={Fabric={AdminUsername=${ADMINUSER},AdminPassword=${ADMINPWD}}}"


# wait until the network is created