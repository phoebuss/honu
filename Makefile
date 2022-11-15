TOP := $(shell readlink -f $(dir $(lastword $(MAKEFILE_LIST))))

include $(TOP)/mk/init.mk
