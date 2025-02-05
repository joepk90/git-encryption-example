# To Do:
- [x] improve git configuration - make a new file, or append to an existing file
  - [ ] use directory and instead just check if the import is in the main hook file
        git hook file? https://stackoverflow.com/questions/26624368/handle-multiple-pre-commit-hooks
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


- [ ] advanced git configuration - this seems diffifult...
- [ ] make `git checkout` decrypt file?
- [ ] make `git status` ignore decrypted file?
- [ ] make `git commit` encrypt staged secret files?
- [ ] add initialise make command which decrypts all files (but git won't notice due to the above requirements)
---
- [ ] make it possible to decrypt a files on open in vscode? (the advanced git configuration task would be better)
- [ ] make the bash directory it's own repo? - use git submodules - OR - make bash scriipts a bash package? https://github.com/bpkg/bpkg