#!/bin/bash

# import utils
. ./bash/utils.sh

# checks
is_seed_populated

# get a list of all staged git files
STAGED_FILES=$(git diff --cached --name-only)

for file in $STAGED_FILES; do

    # if file path does not include the secrets extension, continue to the next item
    if [[ "$file" != *"$SECRETS_EXT"* ]]; then
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