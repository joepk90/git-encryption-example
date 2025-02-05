PROJECT_NAME=git-encryption-example

# make bash scripts executable
bash-scripts-configure:
	# chmod +x ./bash/*
	chmod +x ./bash/encrypt-file.sh
	chmod +x ./bash/encrypt-all.sh
	chmod +x ./bash/decrypt-file.sh
	chmod +x ./bash/decrypt-all.sh
	chmod +x ./bash/check-all.sh
	chmod +x ./bash/check-staged.sh
	chmod +x ./bash/utils.sh

# configure gits precommit hook
# it must be renamed to pre-commit in order for git to use it.
git-configure-hooks:
	. ./bash/git-configure-hooks.sh

# this command currently is not used
# TODO: work out how to reuse it in all the other commands
secrets-export-vars:
	@export SECRETS_EXT=${SECRETS_EXT} && . ./.env && \

# encrypt a single secret filee - example usage:
# make secret-encrypt file="src/test/text.secret"
secret-encrypt:
	bash ./bash/encrypt-file.sh $(ARGS)

# decrypt a single secret file - example usage:
# make secret-decrypt file="src/test/text.secret"
secret-decrypt:
	bash ./bash/decrypt-file.sh $(ARGS)

# encrypt all secret files
secrets-encrypt-all:
	bash ./bash/encrypt-all.sh
	
# decrypt all secret files
secrets-decrypt-all:
	bash ./bash/decrypt-all.sh

# check all secret files are encrypted
secrets-check-all:
	bash ./bash/check-all.sh

# check all staged (git) secret files are encrypted
secrets-check-staged:
	bash ./bash/check-staged.sh

# TODO rename bash directory to encrypt?
# this is a tempoary command, designed to be used on other projects using these bash scripts
# this command is not meant to be used on this (git-encryption-example) project
update-bash-scripts:
	rm -rf ./bash/*
	cp -r ../${PROJECT_NAME}/bash ${PWD}/bash 
	rm ./bash/readme.md