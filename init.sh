#!/bin/bash

GPG=`which gpg`
GPGSTAT=$?

if [[ "$GPGSTAT" -ne "0" ]]; then
	echo "GPG not found. Exiting..."
	exit 1
fi

if [[ ! -d ~/.ansible-vvs ]]; then
	echo "Creating ~/.ansible-vvs..."
	mkdir ~/.ansible-vvs
	chmod 700 ~/.ansible-vvs
fi

if [[ ! -f ~/.ansible-vvs/vault-pw ]]; then
	echo "Please enter your GPG password to decrypt vault.txt"
	$GPG -d vault.txt > ~/.ansible-vvs/vault-pw 2>/dev/null
	chmod 600 ~/.ansible-vvs/vault-pw
else
	echo "vault.txt already decrypted. Use '--vault-password-file ~/.ansible-vvs/vault-pw'"
fi
