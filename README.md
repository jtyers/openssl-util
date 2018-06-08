# openssl-util
Easily create root and intermediate CAs with OpenSSL for testing

```
openssl utility script

operations:
--create-root			create a root CA (self-signed)
--create-intermediate		create an intermediate CA
--create-certificate		create a certificate signed by an intermediate CA

options:
--root-path			path to root CA folder (either to create or to
				link to intermediate CA)
--intermediate-path		path to intermediate CA folder (either to create or to
				link to certificate)
--certificate-type		type of cert to create when --create-certificate is used;
				can be either "user" or "server" (defaults to server)
```
