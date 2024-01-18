# to disable all build-in rules
MAKEFLAGS += --no-builtin-rules

.PHONY: all
all:
	@echo -n

.PHONY: clean
clean:
	@echo -n

$(BUILD_DIR)/%.o: $(TOP)/%.c
	$(MKDIR) $(@D)
	$(eval CFLAGS := $($(<D)_CFLAGS))
	$(strip $(CC) $(CFLAGS) -c -o $@ $<)

$(BUILD_DIR)/%.d: $(TOP)/%.c
	$(MKDIR) $(@D)
	$(eval CFLAGS := $($(<D)_CFLAGS))
	@$(strip $(CC) $(CFLAGS) -MM -MG $^) |\
	sed 's@^\(.*\)\.o@$(@D)\1.d $(@D)\1.o@' |\
	tee $@ |\
	sed 's@^.*:\ \(.*\)@\1@' |\
	sed -e 's@\ @:\n@' -e 's@$$@:@' >> $@

$(BUILD_DIR)/host/%.o: $(TOP)/%.c
	$(MKDIR) $(@D)
	$(eval CFLAGS := $($(<D)_CFLAGS))
	$(strip $(HCC) $(CFLAGS) -c -o $@ $<)

$(BUILD_DIR)/host/%.d: $(TOP)/%.c
	$(MKDIR) $(@D)
	$(eval CFLAGS := $($(<D)_CFLAGS))
	$(strip $(HCC) $(CFLAGS) -MM -MG $^) |\
	sed 's@^\(.*\)\.o@$(@D)\1.d $(@D)\1.o@' |\
	tee $@ |\
	sed 's@^.*:\ \(.*\)@\1@' |\
	sed -e 's@\ @:\n@' -e 's@$$@:@' >> $@
