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

# Update these values, then `source` this script
export REGION=us-east-1
export NETWORKNAME=byzantine-flu-us
export MEMBERNAME=KeyholeSoftware
export NETWORKVERSION=1.2
export ADMINUSER=byzantineAdmin
export ADMINPWD=ilMBC.2019

echo Downloading and installing model file for new service
cd ~
aws s3 cp s3://us-east-1.managedblockchain-preview/etc/service-2.json .
aws configure add-model --service-model file://service-2.json

# No need to change anything below here
aws configure set region $REGION
export NETWORKID=$(aws managedblockchain list-networks --region $REGION -name $NETWORKNAME --query 'Networks[0].Id' --output text)
export MEMBERID=$(aws managedblockchain list-members --network-id $NETWORKID --name $MEMBERNAME --query 'Members[0].Id' --output text)
VpcEndpointServiceName=$(aws managedblockchain get-network --region $REGION --network-id $NETWORKID --query 'Network.VpcEndpointServiceName' --output text)
OrderingServiceEndpoint=$(aws managedblockchain get-network --region $REGION --network-id $NETWORKID --query 'Network.FrameworkAttributes.Fabric.OrderingServiceEndpoint' --output text)
CaEndpoint=$(aws managedblockchain get-member --region $REGION --network-id $NETWORKID --member-id $MEMBERID --query 'Member.FrameworkAttributes.Fabric.CaEndpoint' --output text)
nodeID=$(aws managedblockchain list-nodes --region $REGION --network-id $NETWORKID --member-id $MEMBERID --query 'Nodes[0].Id' --output text)
peerEndpoint=$(aws managedblockchain get-node --region $REGION --network-id $NETWORKID --member-id $MEMBERID --node-id $nodeID --query 'Node.FrameworkAttributes.Fabric.PeerEndpoint' --output text)
peerEventEndpoint=$(aws managedblockchain get-node --region $REGION --network-id $NETWORKID --member-id $MEMBERID --node-id $nodeID --query 'Node.FrameworkAttributes.Fabric.PeerEventEndpoint' --output text)
export ORDERINGSERVICEENDPOINT=$OrderingServiceEndpoint
export ORDERINGSERVICEENDPOINTNOPORT=${ORDERINGSERVICEENDPOINT::-6}
export VPCENDPOINTSERVICENAME=$VpcEndpointServiceName
export CASERVICEENDPOINT=$CaEndpoint
export PEERNODEID=$nodeID
export PEERSERVICEENDPOINT=$peerEndpoint
export PEERSERVICEENDPOINTNOPORT=${PEERSERVICEENDPOINT::-6}
export PEEREVENTENDPOINT=$peerEventEndpoint

echo Useful information used in Cloud9
echo REGION: $REGION
echo NETWORKNAME: $NETWORKNAME
echo NETWORKVERSION: $NETWORKVERSION
echo ADMINUSER: $ADMINUSER
echo ADMINPWD: $ADMINPWD
echo MEMBERNAME: $MEMBERNAME
echo NETWORKID: $NETWORKID
echo MEMBERID: $MEMBERID
echo ORDERINGSERVICEENDPOINT: $ORDERINGSERVICEENDPOINT
echo ORDERINGSERVICEENDPOINTNOPORT: $ORDERINGSERVICEENDPOINTNOPORT
echo VPCENDPOINTSERVICENAME: $VPCENDPOINTSERVICENAME
echo CASERVICEENDPOINT: $CASERVICEENDPOINT
echo PEERNODEID: $PEERNODEID
echo PEERSERVICEENDPOINT: $PEERSERVICEENDPOINT
echo PEERSERVICEENDPOINTNOPORT: $PEERSERVICEENDPOINTNOPORT
echo PEEREVENTENDPOINT: $PEEREVENTENDPOINT

# Exports to be exported before executing any Fabric 'peer' commands via the CLI
cat << EOF > peer-exports.sh
export MSP_PATH=/opt/home/admin-msp
export MSP=$MEMBERID
export ORDERER=$ORDERINGSERVICEENDPOINT
export PEER=$PEERSERVICEENDPOINT
export CHANNEL=mychannel
export CAFILE=/opt/home/managedblockchain-tls-chain.pem
export CHAINCODENAME=mycc
export CHAINCODEVERSION=v0
export CHAINCODEDIR=github.com/chaincode_example02/go
EOF
