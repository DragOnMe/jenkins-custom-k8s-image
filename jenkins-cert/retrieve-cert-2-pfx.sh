#!/bin/bash
SRCFILE=$KUBECONFIG
PFXFILE="jenkins-cert.pfx"

echo "Retrieving cert values from config source($SRCFILE)"
echo "Output file: $PFXFILE"
echo `awk '/certificate-authority-data/{print $2}' $SRCFILE` | base64 -d > ca.crt
echo `awk '/client-certificate-data/{print $2}' $SRCFILE` | base64 -d > client.crt
echo `awk '/client-key-data/{print $2}' $SRCFILE` | base64 -d > client.key
openssl pkcs12 -export -out ${PFXFILE} -inkey client.key -in client.crt -certfile ca.crt
echo "Please memorize your passphrase for later use"
echo "Done."
