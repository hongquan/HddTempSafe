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


install: hddtemp-safe.lua
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp $< $(DESTDIR)$(PREFIX)/bin/hddtemp-safe

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/hddtemp-safe

