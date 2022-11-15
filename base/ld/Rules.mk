TARGET := linker.ld
TYPE := copy
EXPORT := LINKER_SCRIPT

ifeq ($(PLATFORM),esp32)
SRCS := esp32.ld
endif

$(call register_target)
