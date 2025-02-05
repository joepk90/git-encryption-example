#!/bin/sh

# this script is just for git hooks.
# in order for this script to work, copy it to the .git/hooks directory + rename the file to pre-commit
# see make command: (git-precommit-hook-configure)

# source env vars
. ./.env 

# check all staged files have been encrypted
./bash/check-staged.sh