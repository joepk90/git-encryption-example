#!/bin/bash

# check encryption seed has been populated
./bash/seed.sh

if [[ "$file" != *.$SECRETS_EXT ]]; then
    echo "Error: The input file must have a .$SECRETS_EXT extension."
    exit 1
fi

DECRYPTED_TEXT=$(openssl aes-256-cbc -a -salt -pbkdf2 -pass pass:$ENCRYPTION_SEED -in "$file")
echo "$DECRYPTED_TEXT" > $file

echo "File encrypted"