# Bash and Openssl Encryption

## Configuration

### Salting (Randomisation)
The `openssl` configuratin uses `-nosalt` flag. This is to revent randomisation of the encypted ouput. This is to prevent the encrypted files from consitently changing so they don't need to be constantly re-added in git.

If randomisation is desired, use the `-salt` flag instead.

For more information see this thread:
https://askubuntu.com/questions/647404/why-hash-file-are-always-different-in-openssl-aes-256-cbc-output-files

It could be good to make this configurable option somehow...