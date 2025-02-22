# Git Encryption Example
The project uses a [bash-encrypt](https://github.com/joepk90/bash-encryptopenssl) package to encrypt and decrypt files.

The project surves as an example approach to encrypting and decrypting files that can then be stored in git.

For a file to be committed, it must be encrypted. This means that for a file to be considered clean and committed, it must be encrypted.

### Important!
To enforce the behavour of only committing encrypted files, there is a pre-comit git hook that can be used. However this must be enabled each time the project is cloned. It does not work by default. It can be enbled using a single command. See the Project Setup steps below, or the Make commands.

If you want to search all the encrypted files, there is a make command that can be used to decrypt them all. This will mean there are lots of files git will consider as dirty (changed). Once the encrypted files have been searched, a command can then be used to encrypt them all again...

---

## Project Setup

Clone the repo to your project
```
git clone git@github.com:joepk90/bash-encrypt.git
```

Or clone it as a submodule if you want to contribute
```
git submodule add git@github.com:joepk90/bash-encrypt.git
```


imported the Makefile commmands by including the following line at the top of your projects root Makefile:
```
# ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
# include $(ROOT_DIR)/bash-encrypt/BashEncryptMf.mk
```

Initialise the project by configuring making the bash scripts executable:
```
make bash-scripts-configure
```

Then configure git pre commit hook. This will prevent unencrypted secrets from being committed:
```
make git-configure-hooks
```

Create an .env file in the root directory with the following text:
```
export BASH_ENCRYPT_SEED="12345"
export BASH_ENCRYPT_SECRETS_EXT="secret"
```

_Note: this project is for demonstrative purposes only which is why I have docucumented the `ENCRYPTION_SEED` value in this readme._ 


## Reusing the bash scripts in seperate project






### Consideration (To Do)
This is obviously quite a hacky approach to reusing the bash scripts...
It could be worth converting this into a package that can be imported into other repoistories.