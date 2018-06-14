#!/bin/sh

set -eu

tmp_root=`mktemp -d`

./openssl-util --create-root --root-path $tmp_root/root \
	--subject '/CN=openssl-util test root cert/OU=Cryptography Dept/O=Acme Inc/ST=England/C=GB/'
./openssl-util --create-intermediate --intermediate-path $tmp_root/intermediate \
	--root-path $tmp_root/root \
	--subject '/CN=openssl-util test intermediate cert/OU=Cryptography Dept/O=Acme Inc/ST=England/C=GB/'

# as the script is self-verifying, set -e will catch any cert errors

rm -rf $tmp_root