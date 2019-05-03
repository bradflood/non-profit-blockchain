# Notes on client node configuration

This section will describe the client node configuration as it exists at creation.

The client node configuration is created from ami-0434d5878c6ad6d4c (in us-east-1)

## Directory Structure

- /home/ec2-user/go (result of ```go get -u github.com/hyperledger/fabric-ca/cmd/...``` followed by ```make fabric-ca-client```)
  - src/github.com/hyperledger/fabric-ca
    - bin (this is added to PATH)
      - fabric-ca-client
        - api
        - docker
        - Makefile
    - bin
      - fabric-ca-client
      - fabric-ca-server
- /home/ec2-user/fabric-samples (result of git clone <https://github.com/hyperledger/fabric-samples.git>)
  - chaincode (this is mounted in the docker cli)
    - chaincode_example02
      - go
        - chaincode_example02.go
      - java (added after release 1.2)
      - node
    - fabric-ca
    - ngo (this is copied from non-profit-blockchain/ngo-chaincode/src in Part 2, Step 2)
      - ngo.js

## Docker Mounts

- /home/ec2-user <> /opt/home
- /home/ec2-user/fabric-samples/chaincode <> /opt/gopath/src/github.com

## Chaincode dir inside docker cli

- /opt/gopath/src/github.com <> /home/ec2-user/fabric-samples/chaincode
  - chaincode_example02/go/chaincode_example02.go
  - ngo (this is added )
    - ngo.js

## Value of CHAINCODEDIR

github.com/chaincode_example02/go

so this means that the Chaincode dir root, from the fabric cli perspective, must be /opt/gopath/src

## Edits to ~/.bash_profile

```bash
if [ -f ~/fabric-exports-byzantine-flu-us.sh ]; then
    source ~/non-profit-blockchain/ngo-fabric/fabric-exports-byzantine-flu-us.sh
fi
if [ -f ~/peer-exports.sh ]; then
    source ~/peer-exports.sh
fi
```

## Troubleshooting chaincode calls

```bash
docker exec -e "CORE_PEER_TLS_ENABLED=true" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/home/managedblockchain-tls-chain.pem" \
    -e "CORE_PEER_ADDRESS=$PEER" -e "CORE_PEER_LOCALMSPID=$MSP" -e "CORE_PEER_MSPCONFIGPATH=$MSP_PATH" \
    cli peer chaincode list -C mychannel  --installed

docker exec -e "CORE_PEER_TLS_ENABLED=true" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/home/managedblockchain-tls-chain.pem" \
    -e "CORE_PEER_ADDRESS=$PEER" -e "CORE_PEER_LOCALMSPID=$MSP" -e "CORE_PEER_MSPCONFIGPATH=$MSP_PATH" \
    cli peer chaincode list -C mychannel  --instantiated
```