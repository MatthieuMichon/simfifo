GHDL = ghdl
GHDLFLAGS = --std=08
MODULES = \
	simfifo_pkg.o \
	simfifo_tb.o \
	simfifo_tb

all: $(MODULES)

%: %.o
	$(GHDL) elaborate $(GHDLFLAGS) $@
	$(GHDL) run $(GHDLFLAGS) $@ -gFORCE_FAILURE=0

%.o: %.vhd
	$(GHDL) analyze $(GHDLFLAGS) $<

.PHONY: clean
clean:
	$(RM) *.cf *.o simfifo_tb
