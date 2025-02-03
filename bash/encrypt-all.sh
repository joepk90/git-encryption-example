#!/bin/bash

# import utils
. ./bash/utils.sh

# checks
is_seed_populated

for file in $(find ./ -type f -path "*.$SECRETS_EXT"); do
    
    IS_ENCRYPTED=$(openssl aes-256-cbc -d -a -nosalt -pbkdf2 -pass pass:$ENCRYPTION_SEED -in "$file" -out /dev/null 2>/dev/null && echo "true" || echo "false")

    # if file is already encrypted, skip trying to encrypt the file
    if [ "$IS_ENCRYPTED" = "true" ]; then
        continue
    fi

    ENCRYPTED_TEXT=$(openssl aes-256-cbc -a -nosalt -pbkdf2 -pass pass:$ENCRYPTION_SEED -in "$file")
    echo "$ENCRYPTED_TEXT" > "${file}"
    
done