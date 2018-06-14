# openssl-util
Easily create root and intermediate CAs with OpenSSL for testing. Inspired by the excellent OpenSSL CA tutorial by Jamie Nguyen over at https://jamielinux.com/



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

## Installation
Clone this repository and add `openssl-util` to your `PATH`. The only requirement is that you have `openssl` installed (which can be OpenSSL or LibreSSL).

## Usage
To create a self-signed root CA:

	openssl-util --create-root --root-path ~/my-root

Under `~/my-root` you will find:

```
	openssl.my-root.cnf		# openSSL config file
	private/
		my-root.key.pem		# root CA encrypted private key (4096-bits)
		my-root.passphrase		# passphrase for private key, randomly-generated
	certs/
		my-root.crt.pem		# root CA certificate

```

This root can now sign other certificates. So, to create an issuer CA that is signed by our root, do this:

	openssl-util --create-intermediate --root-path ~/my-root --intermediate-path ~/my-issuer

You can also specify `--subject` if you like, which will stop OpenSSL prompting you for the subject on the command line. For example:
	openssl-util --create-intermediate --root-path ~/my-root --intermediate-path ~/my-issuer \
		--subject '/CN=openssl-util test intermediate cert/OU=Cryptography Dept/O=Acme Inc/ST=England/C=GB/'

You now have an issuer CA! Under `~/my-issuer` you will find:

```
	openssl.my-issuer.cnf		# openSSL config file
	private/
		my-issuer.key.pem		# issuer CA encrypted private key (2048-bits)
		my-issuer.passphrase	# passphrase for private key, randomly-generated
	certs/
		my-issuer.crt.pem		# issuer CA certificate
		my-issuer-chain.crt.pem	# PEM containing issuer CA certificate and root CA certificate

```

Finally, with your issuer you can create server or user certificates. They'll be signed by the issuer.

	openssl-util --create-certificate --root-path ~/my-root --intermediate-path ~/my-issuer \
		--certificate-type server --certificate-name my-certificate

Once you've done this, your certificate will be available under `~/my-issuer` (since that is the CA that signed the certificate):


```
	private/
		my-certificate.key.pem		# certificate encrypted private key (2048-bits)
		my-certificate.passphrase	# passphrase for private key, randomly-generated
	certs/
		my-certificate.crt.pem		# certificate
```

You can also specify `--certificate-type user`. See the sources for information on how these differ.