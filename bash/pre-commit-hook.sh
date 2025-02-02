#!/bin/sh

# this script is just for git hooks.
# in order for this script to work, copy it to the .git/hooks directory + rename the file to pre-commit
# see make command: (git-precommit-hook-configure)

# source env vars
. ./.env 

# TODO: update this script so that it only checks staged files - files that would get committed unencrypted

# check all files have been encrypted
./bash/check-staged.sh