#!/bin/bash

# check encryption seed has been populated
./bash/seed.sh

for file in $(find ./ -type f -path "*.$SECRETS_EXT"); do
    DECRYPTED_TEXT=$(openssl aes-256-cbc -d -a --nosalt -pbkdf2 -pass pass:$ENCRYPTION_SEED -in "$file")
    echo "$DECRYPTED_TEXT" > "${file}"
done


