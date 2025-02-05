#!/bin/bash

# import utils
. ./bash/utils.sh

# export environment variable
export_secret_var

# checks
is_seed_populated

# check all secrets files are encrypted
for file in $(get_all_secrets); do
    
    IS_ENCRYPTED=$(is_file_encrypted $file)

    if [ "$IS_ENCRYPTED" = "false" ]; then
        echo "ERROR: Some staged files are not encrypted or the decryption failed."
        echo "The first files found was: $file"
        exit 1
    fi

done

 echo "All secrets are enrypted :)"