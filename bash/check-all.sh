#!/bin/bash

# import utils
. ./bash/utils.sh

# checks
is_seed_populated

# check all secrets files are encrypted
for file in $(find ./ -type f -path "*.$SECRETS_EXT"); do
    
    IS_ENCRYPTED=$(is_file_encrypted $file)

    if [ "$IS_ENCRYPTED" = "false" ]; then
        echo "ERROR: Some staged files are not encrypted or the decryption failed."
        echo "The first files found was: $file"
        exit 1
    fi

done

 echo "All secrets are enrypted :)"