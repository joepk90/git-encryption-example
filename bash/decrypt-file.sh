#!/bin/bash

# import utils
. ./bash/utils.sh

# export environment variable
export_secret_var

# checks
is_seed_populated
file_has_valid_extension
if_decrypted_abort "$file"


# decrypt the file
decrypt_file "$file"

echo "File decrypted."