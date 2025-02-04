# To Do:
- [ ] Create a script ignores all unencrypted & dirty secrets files. make it so that when terraform plan/apply is run,
the unencrypted & dirty secrets files are left untouched... Might need to save a list to a file when all the files are decrypted?
- [ ] capture dirty/decrypted files in variable
- [ ] run custom command
- [ ] encrypt all files, then decrypt the captured dirty/decrypted files
- [ ] make command with call back?
  
  example flow:
  export DECRYPTED_DIRTY_FILES=""
  make decrype-all-files
  make custom-command (terraform plan)
  make encrypt-all-files
  make decrypt-file-list DECRYPTED_DIRTY_FILES

  ---

- [ ] ultiple git hook file? https://stackoverflow.com/questions/26624368/handle-multiple-pre-commit-hooks
- [ ] make the bash directory it's own repo? - use git submodules - OR - make bash scriipts a bash package? https://github.com/bpkg/bpkg
- [ ] make it possible to decrypt a files on open in vscode? (the advanced git configuration task would be better)
- [ ] advanced git configuration
  - [ ] make `git checkout` decrypt file?
  - [ ] make `git status` ignore decrypted file?
  - [ ] make `git commit` encrypt staged secret files?
  - [ ] add initialise make command which decrypts all files (but git won't notice due to the above requirements)