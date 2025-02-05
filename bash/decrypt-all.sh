#!/bin/bash

# import utils
. ./bash/utils.sh

# export environment variable
export_secret_var

# checks
is_seed_populated

for file in $(get_all_secrets); do

    IS_ENCRYPTED=$(is_file_encrypted $file)
    
    # if file is already decrypted, skip trying to decrypt the file
    if [ "$IS_ENCRYPTED" = "false" ]; then
        continue
    fi
    
    decrypt_file $file
    
done