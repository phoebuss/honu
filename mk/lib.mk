OBJS := $(patsubst $(TOP)/%.c,$(BUILD_DIR)/%.o,$(wildcard $(addprefix $(D)/,$(SRCS))))
$(D)_CFLAGS := $(DEFAULT_CFLAGS) $(CFLAGS) $(addprefix -I,$(INCLUDES))

# include dependences if exist
include $(wildcard $(OBJS:.o=.d))

# dependence rules
$(foreach _OBJ,$(OBJS),$(_OBJ): $(_OBJ:.o=.d))

$(T$(D)): $(DEPS) $(OBJS)
	$(MKDIR) $(@D)
	$(eval LIBS := $(foreach _LIB,$(filter LIB_%,$^),$($(_LIB))))
	$(eval OBJS := $(filter %.o,$^))
	$(strip $(AR) crs $@ $(LIBS) $(OBJS))
