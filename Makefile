include ./bash-encrypt/BashEncryptMf.mk

# including makes files normally, retains the make file auto completion
# However if the full path is not used, when running these scripts via other make commands from
# sub directories (`make apply` with terraform), the command break... 

# the solution is to use the full path to the make file, but this breaks the auto completion
# ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
# include $(ROOT_DIR)/bash-encrypt/BashEncryptMf.mk