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

# REPODIR points to this repo
# LOCALCA points to the location of the TLS cert
REPODIR=~/non-profit-blockchain
PROFILEDIR=/tmp
LOCALCA=/home/ec2-user/managedblockchain-tls-chain.pem 

#copy the connection profiles
mkdir -p $PROFILEDIR/connection-profile/org1
cp $REPODIR/ngo-rest-api/connection-profile/ngo-connection-profile-template.yaml $PROFILEDIR/connection-profile/ngo-connection-profile.yaml
cp $REPODIR/ngo-rest-api/connection-profile/client-org1.yaml $PROFILEDIR/connection-profile/org1

#update the connection profiles with endpoints and other information
sed -i "s|%PEERNODEID%|$PEERNODEID|g" $PROFILEDIR/connection-profile/ngo-connection-profile.yaml
sed -i "s|%MEMBERID%|$MEMBERID|g" $PROFILEDIR/connection-profile/ngo-connection-profile.yaml
sed -i "s|%CAFILE%|$LOCALCA|g" $PROFILEDIR/connection-profile/ngo-connection-profile.yaml
sed -i "s|%ORDERINGSERVICEENDPOINT%|$ORDERINGSERVICEENDPOINT|g" $PROFILEDIR/connection-profile/ngo-connection-profile.yaml
sed -i "s|%ORDERINGSERVICEENDPOINTNOPORT%|$ORDERINGSERVICEENDPOINTNOPORT|g" $PROFILEDIR/connection-profile/ngo-connection-profile.yaml
sed -i "s|%PEERSERVICEENDPOINT%|$PEERSERVICEENDPOINT|g" $PROFILEDIR/connection-profile/ngo-connection-profile.yaml
sed -i "s|%PEERSERVICEENDPOINTNOPORT%|$PEERSERVICEENDPOINTNOPORT|g" $PROFILEDIR/connection-profile/ngo-connection-profile.yaml
sed -i "s|%PEEREVENTENDPOINT%|$PEEREVENTENDPOINT|g" $PROFILEDIR/connection-profile/ngo-connection-profile.yaml
sed -i "s|%CASERVICEENDPOINT%|$CASERVICEENDPOINT|g" $PROFILEDIR/connection-profile/ngo-connection-profile.yaml
sed -i "s|%ADMINUSER%|$ADMINUSER|g" $PROFILEDIR/connection-profile/ngo-connection-profile.yaml
sed -i "s|%ADMINPWD%|$ADMINPWD|g" $PROFILEDIR/connection-profile/ngo-connection-profile.yaml

ls -lR $PROFILEDIR/connection-profile