#!/bin/bash

# import utils
. ./bash/utils.sh

# checks
is_seed_populated

for file in $(find ./ -type f -path "*.$SECRETS_EXT"); do
    
    IS_ENCRYPTED=$(is_file_encrypted $file)
    
    # if file is already encrypted, skip trying to encrypt the file
    if [ "$IS_ENCRYPTED" = "true" ]; then
        continue
    fi

    encrypt_file $file

    
done