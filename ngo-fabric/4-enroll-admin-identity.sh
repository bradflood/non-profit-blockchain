## Enroll network member admin
## The variables needed below are exported from step1/2. 
cd ~
fabric-ca-client enroll -u https://$ADMINUSER:$ADMINPWD@$CASERVICEENDPOINT --tls.certfiles /home/ec2-user/managedblockchain-tls-chain.pem -M /home/ec2-user/admin-msp 
cp -r admin-msp/signcerts admin-msp/admincerts
