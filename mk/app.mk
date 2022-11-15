OBJS := $(patsubst $(TOP)/%.c,$(BUILD_DIR)/%.o,$(wildcard $(addprefix $(D)/,$(SRCS))))
DEPS := LIB_START $(DEPS)
$(D)_CFLAGS := $(DEFAULT_CFLAGS) $(CFLAGS) $(addprefix -I,$(INCLUDES))
$(D)_LDFLAGS := $(DEFAULT_LDFLAGS) $(LDFLAGS)

# include dependences if exist
include $(wildcard $(OBJS:.o=.d))

# dependence rules
$(foreach _OBJ,$(OBJS),$(_OBJ): $(_OBJ:.o=.d))

$(T$(D)): $(T$(D):.bin=.elf)
	$(MKDIR) $(@D)
	@echo $<

$(T$(D):.bin=.elf): LINKER_SCRIPT $(DEPS) $(OBJS)
	$(MKDIR) $(@D)
	$(eval LIBS := $(foreach _LIB,$(filter LIB_%,$^),$($(_LIB))))
	$(eval OBJS := $(filter %.o,$^))
	$(eval LDFLAGS := $($(@D:$(BUILD_DIR)%=$(TOP)%)_LDFLAGS))
	$(strip $(LD) $(LDFLAGS) -o $@ -T $(LINKER_SCRIPT) $(LIBS) $(OBJS))
