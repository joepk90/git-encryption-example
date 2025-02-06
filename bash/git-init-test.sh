# (all `git` cmds)
pre_git_hook()
{
    # echo "=== Running pre_git_hook() function. ==="  # debugging
    # do stuff
    true  # do nothing (bash functions can't be empty); delete this line
          # once you add your own code
}
post_git_hook()
{
    # echo "=== Running post_git_hook() function. ==="  # debugging
    # do stuff
    true  # do nothing (bash functions can't be empty); delete this line
          # once you add your own code
}

# status
pre_git_status_hook()
{
    # echo "=== Running pre_git_status_hook() function. ==="  # debugging
    # do stuff
    true  # do nothing (bash functions can't be empty); delete this line
          # once you add your own code
}
post_git_status_hook()
{
    # echo "=== Running post_git_status_hook() function. ==="  # debugging
    # do stuff
    true  # do nothing (bash functions can't be empty); delete this line
          # once you add your own code
}

# commit
pre_git_commit_hook()
{
    # echo "=== Running pre_git_commit_hook() function. ==="  # debugging
    # do stuff
    true  # do nothing (bash functions can't be empty); delete this line
          # once you add your own code
}
post_git_commit_hook()
{
    # echo "=== Running post_git_commit_hook() function. ==="  # debugging
    # do stuff
    true  # do nothing (bash functions can't be empty); delete this line
          # once you add your own code
}

# push
pre_git_push_hook()
{
    # echo "=== Running pre_git_push_hook() function. ==="  # debugging
    # do stuff
    true  # do nothing (bash functions can't be empty); delete this line
          # once you add your own code
}
post_git_push_hook()
{
    # echo "=== Running post_git_push_hook() function. ==="  # debugging
    # do stuff
    true  # do nothing (bash functions can't be empty); delete this line
          # once you add your own code
}

# pull
pre_git_pull_hook()
{
    # echo "=== Running pre_git_pull_hook() function. ==="  # debugging
    # do stuff
    true  # do nothing (bash functions can't be empty); delete this line
          # once you add your own code
}
post_git_pull_hook()
{
    # echo "=== Running post_git_pull_hook() function. ==="  # debugging
    # do stuff
    true  # do nothing (bash functions can't be empty); delete this line
          # once you add your own code
}


# Outer-most git hook wrapper function
custom_git()
{
    echo "=== Running custom custom_git() wrapper function. ==="  # debugging

    # Note: if no argument is passed in, this just sets cmd to an empty string
    cmd="$1"
    # echo "cmd = $cmd"  # debugging

    # Pre-hooks
    pre_git_hook
    # Note: in Bash if statements, `[[ ]]` is recommended over `[ ]` because
    # `[[ ]]` is faster. See my answer here:
    # https://stackoverflow.com/a/77291070/4561887
    if [[ "$cmd" == "status" ]]; then
        pre_git_status_hook
    elif [[ "$cmd" == "commit" ]]; then
        pre_git_commit_hook
    elif [[ "$cmd" == "push" ]]; then
        pre_git_push_hook
    elif [[ "$cmd" == "pull" ]]; then
        pre_git_pull_hook
    fi

    # Run the actual git command; the `command` built-in is used to force the
    # real `git` command to get called here, to prevent infinite recursion.
    command git "$@"
    return_val="$?"

    # Post-hooks
    if [[ "$cmd" == "status" ]]; then
        post_git_status_hook
    elif [[ "$cmd" == "commit" ]]; then
        post_git_commit_hook
    elif [[ "$cmd" == "push" ]]; then
        post_git_push_hook
    elif [[ "$cmd" == "pull" ]]; then
        post_git_pull_hook
    fi
    post_git_hook

    # Be sure to return the return value of the actual git command, not the
    # return value of this function nor our hooks.
    return "$return_val"
}