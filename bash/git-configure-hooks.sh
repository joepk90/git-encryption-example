#!/bin/bash

# TODO: potentially make more reusable...
# - might need to use this logic to configure either git hooks

# TO DO:
# instead of this, create a new file called ./bash/hooks/pre-commit.d.sh",
# which imports the ./bash/hooks/pre-commit.sh file, then
# just check that the import statement exists for the ./bash/hooks/pre-commit.d.sh,
# in the existing pre-commit file. THIS SHOULD BE MUCH SIMPLER!


GIT_PRECOMMIT_FILE=".git/hooks/pre-commit"
BASH_PRECOMMIT_FILE="./bash/hooks/pre-commit.sh"

make_script_executable() {
	chmod +x "$1"
}

make_pre_commit_script_executable() {
	make_script_executable "$GIT_PRECOMMIT_FILE"
}

get_git_script_text() {
	cat "$GIT_PRECOMMIT_FILE"
}

get_bash_script_text() {
	cat "$BASH_PRECOMMIT_FILE"
}

# remove spaces and new lines from text
compress_text() {
	TEXT=$1
	echo "$TEXT" | tr -d '[:space:]'
}

remove_first_line_from_text() {
	trimmed_text=$(echo "$1" | tail -n +2)
	echo "$trimmed_text"
}

get_compressed_git_pre_commit_script() {
	git_pre_commit_script_text=$(get_git_script_text)
	compressed_text=$(echo $(compress_text "$git_pre_commit_script_text"))
	echo "$compressed_text"
}

get_git_pre_commit_script_no_first_line() {
	bash_pre_commit_script_text=$(get_bash_script_text)
	trimmed_text=$(remove_first_line_from_text "$bash_pre_commit_script_text")
	echo "$trimmed_text"
}

get_compressed_bash_pre_commit_script() {
	bash_pre_commit_script_text_no_first_line=$(get_git_pre_commit_script_no_first_line)
	compressed_text=$(echo $(compress_text "$bash_pre_commit_script_text_no_first_line"))
	echo $compressed_text
}

git_pre_commit_hook_contains_script() {
	bash_pre_commit_script_text_compressed=$(get_compressed_bash_pre_commit_script)
	git_pre_commit_script_text_compressed=$(get_compressed_git_pre_commit_script)

	SCRIPT_EXISTS="false"
	if [[ "$git_pre_commit_script_text_compressed" == *"$bash_pre_commit_script_text_compressed"* ]]; then
		SCRIPT_EXISTS="true"
	fi

	echo $SCRIPT_EXISTS
}

echo "checking if the pre-commit git hook file (."$GIT_PRECOMMIT_FILE") exists"

GIT_HOOK_FILE_EXISTS=$(test -f $GIT_PRECOMMIT_FILE && echo "true" || echo "false")
if [ "$GIT_HOOK_FILE_EXISTS" = "false" ]; then
	echo "the pre-commit git hook file does not exist. Creating it now."
	cp "$BASH_PRECOMMIT_FILE" "$GIT_PRECOMMIT_FILE"
	make_pre_commit_script_executable
	return
fi


SCRIPT_EXISTS=$(git_pre_commit_hook_contains_script)
if [ "$SCRIPT_EXISTS" = "true" ]; then
	echo "the pre-commit git hook file exists and contains the git pre-commit hook script."
else
	bash_pre_commit_script_text_no_first_line=$(get_git_pre_commit_script_no_first_line)
	echo "the pre-commit git hook file exists but does not contain the script. Updating it now..."
	echo "$bash_pre_commit_script_text_no_first_line" >> "$GIT_PRECOMMIT_FILE"
	make_pre_commit_script_executable
	return
fi