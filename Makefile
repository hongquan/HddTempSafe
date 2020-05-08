PREFIX := /usr/local

.PHONY: install uninstall

# When not run as root, install to user home folder
ifndef DESTDIR
# Test if running user is root
ifneq ($(shell id -u), 0)
PREFIX := $(HOME)/.local
endif
endif

all:
	@echo $(PREFIX)

install: hddtemp-safe
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp $< $(DESTDIR)$(PREFIX)/bin/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/hddtemp-safe

