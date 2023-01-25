MDIR := $(shell pwd)
IDIR = $(MDIR)/include
SRCDIR = $(MDIR)/source

BLDDIR = $(MDIR)/build
LIBDIR = $(BLDDIR)/lib
PYDIR = $(MDIR)/python

# .base:
# 	if ! [ -e $(BLDDIR) ]; then mkdir $(BLDDIR) ; mkdir $(LIBDIR); fi;
# 	touch build/.base

$(shell if [ ! -e $(BLDDIR) ];then mkdir $(BLDDIR); mkdir $(LIBDIR); fi)

CC = gcc

default: $(PYDIR)/pytoy

$(BLDDIR)/toy_module.o: $(SRCDIR)/toy_module.c $(IDIR)/toy_module.h
	$(CC) -c $< -o $@  -I $(IDIR)

$(LIBDIR)/libtoy_module.a: $(BLDDIR)/toy_module.o
	ar rcs $@ $^

$(PYDIR)/pytoy: $(PYDIR)/setup.py $(PYDIR)/pytoy.pyx $(LIBDIR)/libtoy_module.a
	python $< build_ext --inplace  && rm -rf $(PYDIR)/build
	python $< install --user && rm $(MDIR)/*.so


.PHONY: clean

clean:
	rm $(BLDDIR)/*.o $(LIBDIR)/*.a $(PYDIR)/*.c
	rm -rf $(BLDDIR)
	rm -rf $(LIBDIR)
