#!/bin/bash

# import utils
. ./bash/utils.sh

# checks
is_seed_populated

for file in $(find ./ -type f -path "*.$SECRETS_EXT"); do

    IS_ENCRYPTED=$(is_file_encrypted $file)
    
    # if file is already decrypted, skip trying to decrypt the file
    if [ "$IS_ENCRYPTED" = "false" ]; then
        continue
    fi
    
    decrypt_file $file
    
done