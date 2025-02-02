#!/bin/bash

# check encryption seed has been populated
./bash/seed.sh

# check all secrets files are encrypted
for file in $(find ./src -type f -path "*.$SECRETS_EXT"); do
    
    IS_ENCRYPTED=$(openssl aes-256-cbc -d -a -nosalt -pbkdf2 -pass pass:$ENCRYPTION_SEED -in "$file" -out /dev/null 2>/dev/null && echo "true" || echo "false")

    if [ "$IS_ENCRYPTED" = "false" ]; then
        echo "Some files are not encrypted or the decryption failed. The first files found was: $file"
        exit 1
    fi

done

 echo "All secrets are enrypted :)"