#!/bin/bash

# import utils
# . ./bash/utils.sh

# https://stackoverflow.com/questions/41847452/git-pre-status-or-post-status-hook
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux

RED='\033[0;31m'
Blue='\033[0;34m'
NC='\033[0m' # No Color
BIGreen='\033[1;92m'  

git_wrapper()
{
    if [[ $# -ge 1 && "$1" == "status" ]]
    then
        printf "${Blue}Your git-status pre-hook should be here testing!${NC}\n"
    fi

    command git "$@"
    return_val="$?"
    return "$return_val"
}

# Unset the git alias when sourcing the completion script
# unalias git 2>/dev/null

# Source the git-completion script
# autoload -Uz compinit && compinit
# if [ -f /usr/share/git/completion/git-completion.bash ]; then
#     . /usr/share/git/completion/git-completion.bash
# elif [ -f /etc/bash_completion.d/git ]; then
#     . /etc/bash_completion.d/git
# fi

# Re-set the git alias
alias git=git_wrapper

printf "\n\n"
printf "${BIGreen}Git has been initialised!${NC}\n"
printf "This will make it easier to use Git Encryption and work with the encrypted files!\n"
printf "To stop using the extended Git features, simply close this shell.\n"
printf "\n\n"