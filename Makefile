PREFIX ?= $(HOME)/.local
BINDIR ?= $(PREFIX)/bin

.PHONY: all install uninstall test

all:
	@echo "sshm is a bash script. Run 'make install' to install to $(BINDIR)."

install:
	install -d $(DESTDIR)$(BINDIR)
	install -m 755 bin/sshm $(DESTDIR)$(BINDIR)/sshm
	@echo "Installed sshm to $(DESTDIR)$(BINDIR)/sshm"

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/sshm
	@echo "Removed sshm from $(DESTDIR)$(BINDIR)/sshm"

test:
	bash -n bin/sshm
	./bin/sshm --version
	./bin/sshm --list
