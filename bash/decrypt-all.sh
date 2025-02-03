#!/bin/bash

# import utils
. ./bash/utils.sh

# checks
is_seed_populated

for file in $(find ./ -type f -path "*.$SECRETS_EXT"); do

    IS_ENCRYPTED=$(openssl aes-256-cbc -d -a -nosalt -pbkdf2 -pass pass:$ENCRYPTION_SEED -in "$file" -out /dev/null 2>/dev/null && echo "true" || echo "false")

    # if file is already decrypted, skip trying to decrypt the file
    if [ "$IS_ENCRYPTED" = "false" ]; then
        continue
    fi
    
    DECRYPTED_TEXT=$(openssl aes-256-cbc -d -a -nosalt -pbkdf2 -pass pass:$ENCRYPTION_SEED -in "$file")
    echo "$DECRYPTED_TEXT" > "${file}"
    
done