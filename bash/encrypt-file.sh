#!/bin/bash

# import utils
. ./bash/utils.sh

# checks
is_seed_populated
file_has_valid_extension
if_encrypted_abort "$file"

# encrypt the file
encrypt_file "$file"

echo "File encrypted."