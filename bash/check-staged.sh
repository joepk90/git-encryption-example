#!/bin/bash

# import utils
. ./bash/utils.sh

# export environment variable
export_secret_var

# checks
is_seed_populated

# get a list of all staged git files
STAGED_FILES=$(git diff --cached --name-only)

for file in $STAGED_FILES; do

    IS_SECRET_FILE=$(file_is_secret $file)

    # if file path does not include the secrets extension, continue to the next item
    if [ "$IS_SECRET_FILE" = "false" ]; then
        continue
    fi

    # if ile path does include the secrets extension, check if the file has been encrypted
    IS_ENCRYPTED=$(is_file_encrypted $file)

    if [ "$IS_ENCRYPTED" = "false" ]; then
        echo "ERROR: Some staged files are not encrypted or the decryption failed."
        echo "The first files found was: $file"
        exit 1
    fi
done