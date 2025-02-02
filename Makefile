# make bash scripts executable
bash-scripts-configure:
	# chmod +x ./bash/*
	chmod +x ./bash/encrypt-file.sh
	chmod +x ./bash/encrypt-all.sh
	chmod +x ./bash/decrypt-file.sh
	chmod +x ./bash/decrypt-all.sh
	chmod +x ./bash/check-all.sh
	chmod +x ./bash/seed.sh

# configure gits precommit hook
# it must be renamed to pre-commit in order for git to use it.
git-precommit-hook-configure:
	@cp ./bash/pre-commit-hook.sh .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit

# this command currently is not used
# TODO: work out how to reuse it in all the other commands
secrets-export-vars:
	@export SECRETS_EXT=${SECRETS_EXT} && . ./.env && \

# encrypt a single secret filee - example usage:
# make secret-encrypt file="src/test/text.secret"
secret-encrypt:
	@export SECRETS_EXT=${SECRETS_EXT} && . ./.env && \
	bash ./bash/encrypt-file.sh $(ARGS)

# decrypt a single secret file - example usage:
# make secret-decrypt file="src/test/text.secret"
secret-decrypt:
	@export SECRETS_EXT=${SECRETS_EXT} && . ./.env && \
	bash ./bash/decrypt-file.sh $(ARGS)

# encrypt all secret files
secrets-encrypt-all:
	@export SECRETS_EXT=${SECRETS_EXT} && . ./.env && \
	bash ./bash/encrypt-all.sh
	
# decrypt all secret files
secrets-decrypt-all:
	@export SECRETS_EXT=${SECRETS_EXT} && . ./.env && \
	bash ./bash/decrypt-all.sh

# check all secret files are encrypted
secrets-check-all:
	@export SECRETS_EXT=${SECRETS_EXT} && . ./.env && \
	bash ./bash/check-all.sh
