$(T$(D)): $(wildcard $(addprefix $(D)/,$(SRCS)))
	$(MKDIR) $(@D)
	$(strip cp $< $@)
