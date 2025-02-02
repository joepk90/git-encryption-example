# Git Encryption Example
The project uses openssl to encrypt and decrypt files.
The project surves as an example approach to encrypting and decrypting files that can then be stored in git.

For a file to be committed, it must be encrypted. This means that for a file to be considered clean and committed, it must be encrypted.

### Important!
To enforce the behavour of only committing encrypted files, there is a pre-comit git hook that can be used. However this must be enabled each time the project is cloned. It does not work by default. It can be enbled using a single command. See the Project Setup steps below, or the Make commands.

If you want to search all the encrypted files, there is a make command that can be used to decrypt them all. This will mean there are lots of files git will consider as dirty (changed). Once the encrypted files have been searched, a command can then be used to encrypt them all again...

---

## Project Setup

Start by configuring making the bash scripts executable:

```make bash-scripts-configure```

Then configure git pre commit hook. This will prevent unencrypted secrets from being committed:

```make git-precommit-hook-configure```

Create an .env file in the root directory with the following text:

```
export ENCRYPTION_SEED="12345"
export SECRETS_EXT="secret"
```

_Note: this project is for demonstrative purposes only which is why I have docucumented the `ENCRYPTION_SEED` value in this readme._ 


## Consideration (To Do)
It could be worth converting this into a package that can be imported into other repoistories.