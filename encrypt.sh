#!/bin/sh

READ_FD=""
READ_FILE="$1"

# Read from fd 8 if -8 is given
if [ "x$1" = "x-8" ]; then
	READ_FD="8"
	READ_FILE="$2"
fi

if [ "x$READ_FILE" = "x" ]; then
	echo "Usage: $0 [-8] <file|->" >&2
	exit 1
fi

GPG="gpg"
GPG_ENCRYPT="$GPG --armor --encrypt --sign --output -"

if [ "x$READ_FD" != "x" ]; then
	GPG_ENCRYPT="$GPG_ENCRYPT --passphrase-fd $READ_FD"
fi


# pub 298CFCE2518BFC29, sub 745F454EC4251E8E, Gerdriaan Mulder <mrngm@moeilijklastig.nl>
GPG_ENCRYPT="$GPG_ENCRYPT -r 745F454EC4251E8E"
# pub 8FE36CA9BF3A1E36, sub E363444AB6A16EB5, Daan Sprenkels <dsprenkels@gmail.com>
GPG_ENCRYPT="$GPG_ENCRYPT -r E363444AB6A16EB5"


echo "Executing: $GPG_ENCRYPT" >&2

$GPG_ENCRYPT "$READ_FILE"
