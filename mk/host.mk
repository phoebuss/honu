OBJS := $(patsubst $(TOP)/%.c,$(BUILD_DIR)/host/%.o,$(wildcard $(addprefix $(D)/,$(SRCS))))
$(D)_CFLAGS := $(DEFAULT_CFLAGS) $(CFLAGS) $(addprefix -I,$(INCLUDES))
$(D)_LDFLAGS := $(LDFLAGS)

# include dependences if exist
include $(wildcard $(OBJS:.o=.d))

# dependence rules
$(foreach _OBJ,$(OBJS),$(_OBJ): $(_OBJ:.o=.d))

$(T$(D)): $(OBJS)
	$(MKDIR) $(@D)
	$(eval OBJS := $(filter %.o,$^))
	$(eval LDFLAGS := $($(@D:$(BUILD_DIR)/host%=$(TOP)%)_LDFLAGS))
	$(strip $(HCC) $(LDFLAGS) -o $@ $(OBJS))
