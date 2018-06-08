#!/bin/sh

set -eu

tmp_root=`mktemp -d`

./openssl-util --create-root --root-path $tmp_root/root <<EOF
GB

London

Acme Inc

Cryptography Dept

openssl-util test root cert

notreal@example.com

EOF

./openssl-util --create-intermediate --intermediate-path $tmp_root/intermediate --root-path $tmp_root/root <<EOF
GB

London

Acme Inc

Cryptography Dept

openssl-util test intermediate cert

notreal@example.com

EOF

