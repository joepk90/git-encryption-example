#!/bin/bash

# check encryption seed has been populated
if [ "$ENCRYPTION_SEED" = "" ]; then
    echo "Error: No encryption seed has been provided."
    echo "The encryoption seed is used to encrypt and decrypt secrets in this project - "See the .env file to add an encryption seed""
    exit 1
fi
