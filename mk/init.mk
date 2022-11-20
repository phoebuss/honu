include $(TOP)/.project
MAKEFLAGS := --no-builtin-rules --no-builtin-variables

PLATFORM := $(CONFIG_PLATFORM)
BUILD_DIR := $(CONFIG_BUILD_DIR)
CROSS_COMPILE := $(CONFIG_TOOLCHAIN_DIR)/bin/$(CONFIG_TOOLCHAIN_PREFIX)

CC := $(CROSS_COMPILE)-cc
LD := $(CROSS_COMPILE)-ld
AR := $(CROSS_COMPILE)-ar

MKDIR := @@mkdir -pv

HCC := $(shell which cc)

ifeq ($(HCC),)
$(error missing cc for host)
endif

DEFAULT_CFLAGS := -O0 -g3 -Wall
DEFAULT_LDFLAGS := -nostartfiles -nostdlib

.DEFAULT_GOAL = T$(CURDIR)

include $(TOP)/mk/function.mk
include $(TOP)/mk/common.mk

include $(TOP)/Rules.mk
