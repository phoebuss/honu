ODIR = $(BUILD_DIR)/$(subst $(TOP)/,,$(D))
$(ODIR):
	mkdir -p $@

T$(D) := $(ODIR)/$(TARGET)
T$(D): $(T$(D))

ifneq ($(EXPORT),)
$(EXPORT) := $(T$(D))
$(EXPORT): $(T$(D))
endif

ifeq ($(TYPE),app)
include $(TOP)/mk/app.mk
else ifeq ($(TYPE),lib)
include $(TOP)/mk/lib.mk
else ifeq ($(TYPE),copy)
include $(TOP)/mk/copy.mk
endif
