#!/bin/bash

# check encryption seed has been populated
./bash/seed.sh

if [[ "$file" != *.$SECRETS_EXT ]]; then
    echo "Error: The input file must have a .$SECRETS_EXT extension."
    exit 1
fi


IS_ENCRYPTED=$(openssl aes-256-cbc -d -a -nosalt -pbkdf2 -pass pass:$ENCRYPTION_SEED -in "$file" -out /dev/null 2>/dev/null && echo "true" || echo "false")

# if file is already encrypted, skip trying to encrypt the file
if [ "$IS_ENCRYPTED" = "true" ]; then
    echo "Aborting! File has already been encrypted..."
    exit 1
fi

DECRYPTED_TEXT=$(openssl aes-256-cbc -a -nosalt -pbkdf2 -pass pass:$ENCRYPTION_SEED -in "$file")

echo "$DECRYPTED_TEXT" > $file

echo "File encrypted"