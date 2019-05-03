# Troubleshooting

Error: [2018-11-06T11:44:51.485] [ERROR] Helper - ##### getRegisteredUser - Failed to get registered user: michael with error: TypeError: Cannot read property 'curve' of undefined

Solution: make sure the certificate stores are removed before starting the REST api. Using `./start.sh` will remove these. The
error is caused by using the wrong certificate - probably an old one from the cert store.


[2018-11-16T10:25:40.240] [ERROR] Connection - ##### getRegisteredUser - Failed to get registered user: 5742cbbe-03b6-449d-ab65-3c885b6bfee1 with error: Error: Enrollment failed with errors [[{"code":19,"message":"CA 'ca.esxh3vewtnhsrldv5du3p52zpq' does not exist"}]]

We need to set the name of the Fabric CA, as set in the CA, in FABRIC_CA_SERVER_CA_NAME



##### invokeChaincode - Invoke transaction request to Fabric {"targets":["peer1"],"chaincodeId":"ngo","fcn":"createSpend","args":["{\"spendId\":\"43a4d8be-c9f7-4d45-9f25-6074d312ee47\",\"spendDescription\":\"Peter Pipers Poulty Portions for Pets\",\"spendDate\":\"2018-09-20T12:41:59.582Z\",\"spendAmount\":22}"],"chainId":"mychannel","txId":{"_nonce":{"type":"Buffer","data":[78,51,96,123,70,26,73,101,108,20,68,49,246,213,77,198,106,37,113,217,60,230,97,118]},"_transaction_id":"c600ae42fc8ef3dffb50a2b27710d2b6488cf7bc2a90032299be78220ae0a113","_admin":false}}
[2019-03-15T05:41:41.344] [ERROR] Invoke - ##### invokeChaincode - received unsuccessful proposal response
[2019-03-15T05:41:41.344] [INFO] Invoke - ##### invokeChaincode - Failed to send Proposal and receive all good ProposalResponse. Status code: undefined, 2 UNKNOWN: access denied: channel [mychannel] creator org [org1MSP]
Error: 2 UNKNOWN: access denied: channel [mychannel] creator org [org1MSP]


The identities used by the REST API are being cached. Remove the cache directories:

```
rm -rf fabric-client-kv-org1/
rm -rf /tmp/fabric-client-kv-org1/
```


# new
[ec2-user@ip-10-0-121-1 ngo-rest-api]$ curl -s -X POST http://localhost:3000/users -H "content-type: application/x-www-form-urlencoded" -d 'username=michael&orgName=Org1'
{"success":false,"message":"failed Error: Enrollment failed with errors [[{\"code\":20,\"message\":\"Authorization failure\"}]]"}[ec2-user@ip-10-0-121-1 ngo-rest-api]$ (node:3546) UnhandledPromiseRejectionWarning: Error: ##### invokeChaincode - Failed to invoke chaincode. cause:Error: ##### getClientForOrg - User was not found : michael
    at Object.invokeChaincode (/home/ec2-user/non-profit-blockchain/ngo-rest-api/invoke.js:180:9)
    at <anonymous>
(node:3546) UnhandledPromiseRejectionWarning: Unhandled promise rejection. This error originated either by throwing inside of an async function without a catch block, or by rejecting a promise which was not handled with .catch(). (rejection id: 1)
(node:3546) [DEP0018] DeprecationWarning: Unhandled promise rejections are deprecated. In the future, promise rejections that are not handled will terminate the Node.js process with a non-zero exit code.
(node:3546) UnhandledPromiseRejectionWarning: Error: ##### invokeChaincode - Failed to invoke chaincode. cause:Error: ##### getClientForOrg - User was not found : michael
    at Object.invokeChaincode (/home/ec2-user/non-profit-blockchain/ngo-rest-api/invoke.js:180:9)
    at <anonymous>
(node:3546) UnhandledPromiseRejectionWarning: Unhandled promise rejection. This error originated either by throwing inside of an async function without a catch block, or by rejecting a promise which was not handled with .catch(). (rejection id: 2)
