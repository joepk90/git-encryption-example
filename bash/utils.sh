#!/bin/bash

export_secret_var() {
    export SECRETS_EXT=${SECRETS_EXT} && . ./.env
}

decrypt_file_text() {
    FILE=$1
    openssl aes-256-cbc -d -a -nosalt -pbkdf2 -pass pass:$ENCRYPTION_SEED -in "$FILE"
}

encrypt_file_text() {
    FILE=$1
    openssl aes-256-cbc -a -nosalt -pbkdf2 -pass pass:$ENCRYPTION_SEED -in "$FILE"
}

encrypt_file() {
    FILE=$1
    ENCRYPTED_TEXT=$(encrypt_file_text "$file")
    echo "$ENCRYPTED_TEXT" > $FILE
}

decrypt_file() {
    FILE=$1
    DECRYPTED_TEXT=$(decrypt_file_text "$file")
    echo "$DECRYPTED_TEXT" > $FILE
}


is_file_encrypted() {
    FILE=$1
    # Attempt to decrypt the specified file and suppress any output (both stdout and stderr).
    # If the decryption is successful, the if condition will be true.
    # This line attempts to decrypt the specified file ($FILE).
    # If the decryption is successful, the command returns a zero exit status.
    # The output of the decryption command is redirected to /dev/null to suppress it.
    # The "2>&1" part redirects any error messages to the same place as the standard output.
    if decrypt_file_text "$FILE" > /dev/null 2>&1; then
        echo "true"
    else
        echo "false"
    fi
}

is_seed_populated() {
    # check encryption seed has been populated
    if [ "$ENCRYPTION_SEED" != "" ]; then
       return
    fi

    echo "Error: No encryption seed has been provided."
    echo "The encryoption seed is used to encrypt and decrypt secrets in this project - "See the .env file to add an encryption seed""
    exit 1
}

file_has_valid_extension() {
    if [[ "$file" == *.$SECRETS_EXT ]]; then
        return
    fi

    echo "Error: The input file must have a .$SECRETS_EXT extension."
    exit 1
}

if_encrypted_abort() {
    FILE=$1
    IS_ENCRYPTED=$(is_file_encrypted $FILE)

    # if file is already encrypted, skip trying to encrypt the file
    if [ "$IS_ENCRYPTED" = "false" ]; then
       return
    fi

    echo "Aborting! File has already been encrypted..."
    exit 1
}

if_decrypted_abort() {
    FILE=$1
    IS_ENCRYPTED=$(is_file_encrypted $FILE)

    # if file is already decrypted, skip trying to decypt the file
    if [ "$IS_ENCRYPTED" = "true" ]; then
        return
    fi

    echo "Aborting! File has already been decrypted..."
    exit 1
}

get_all_secrets() {
    find ./ -type f -path "*.$SECRETS_EXT"
}

file_is_secret() {
    FILE=$1

     # if file path does not include the secrets extension, continue to the next item
    if [[ "$FILE" != *"$SECRETS_EXT"* ]]; then
        echo "false"
    else
        echo "true"
    fi
}