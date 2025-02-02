#!/bin/bash

# check encryption seed has been populated
./bash/seed.sh

# get a list of all staged git files
STAGED_FILES=$(git diff --cached --name-only)

for file in $STAGED_FILES; do

    # if file path does not include the secrets extension, continue to the next item
    if [[ "$file" != *"$SECRETS_EXT"* ]]; then
        continue
    fi

    # if ile path does include the secrets extension, check if the file has been encrypted
    IS_ENCRYPTED=$(openssl aes-256-cbc -d -a -nosalt -pbkdf2 -pass pass:$ENCRYPTION_SEED -in "$file" -out /dev/null 2>/dev/null && echo "true" || echo "false")

    if [ "$IS_ENCRYPTED" = "false" ]; then
        echo "ERROR: Some staged files are not encrypted or the decryption failed."
        echo "The first files found was: $file"
        exit 1
    fi
done