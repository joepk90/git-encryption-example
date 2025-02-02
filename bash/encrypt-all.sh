#!/bin/bash

# check encryption seed has been populated
./bash/seed.sh

for file in $(find ./src -type f -path "*.$SECRETS_EXT"); do
    ENCRYPTED_TEXT=$(openssl aes-256-cbc -a -nosalt -pbkdf2 -pass pass:$ENCRYPTION_SEED -in "$file")
    echo "$ENCRYPTED_TEXT" > "${file}"
done