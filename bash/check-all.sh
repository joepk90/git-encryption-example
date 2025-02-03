#!/bin/bash

# import utils
. ./bash/utils.sh

# checks
is_seed_populated

# check all secrets files are encrypted
for file in $(find ./ -type f -path "*.$SECRETS_EXT"); do
    
    IS_ENCRYPTED=$(openssl aes-256-cbc -d -a -nosalt -pbkdf2 -pass pass:$ENCRYPTION_SEED -in "$file" -out /dev/null 2>/dev/null && echo "true" || echo "false")

    if [ "$IS_ENCRYPTED" = "false" ]; then
        echo "ERROR: Some staged files are not encrypted or the decryption failed."
        echo "The first files found was: $file"
        exit 1
    fi

done

 echo "All secrets are enrypted :)"