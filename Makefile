MDIR := $(shell pwd)
IDIR = $(MDIR)/include
SRCDIR = $(MDIR)/source
MAINDIR = $(MDIR)/main
LOCALDIR :=$(shell python -m site --user-site)

BLDDIR = $(MDIR)/build
LIBDIR = $(BLDDIR)/lib
PYDIR = $(MDIR)/python

$(shell if [ ! -e $(BLDDIR) ];then mkdir $(BLDDIR); mkdir $(LIBDIR); fi)

CC = gcc

default: $(PYDIR)/pytoy

PSPEC.H = $(IDIR)/pspec.h
INPARAM.H = $(IDIR)/inparam.h
TOY.H = $(IDIR)/toy.h

TOY.C = $(MAINDIR)/toy.c
PSPEC.C = $(SRCDIR)/pspec.c

TOY.O = $(BLDDIR)/toy.o
PSPEC.O = $(BLDDIR)/pspec.o

TOY = $(MDIR)/toy

# default: $(PYDIR)/pytoy
default: $(TOY)

$(PSPEC.O): $(PSPEC.C) $(PSPEC.H)
	$(CC) -c $(PSPEC.C) -o $@  -I $(IDIR)

$(LIBDIR)/libtoy_module.a: $(PSPEC.O)
	ar rcs $@ $(PSPEC.O)

$(TOY.O): $(TOY.C) $(PSPEC.C) $(TOY.H) $(PSPEC.H)
	$(CC) -c $(TOY.C) -o $@  -I $(IDIR)

$(TOY): $(TOY.O) $(PSPEC.O) $(TOY.H) $(PSPEC.H)
	$(CC) $(TOY.O) $(PSPEC.O) -o $(TOY)

$(PYDIR)/pytoy: $(PYDIR)/setup.py $(PYDIR)/pytoy.pyx $(LIBDIR)/libtoy_module.a
	python $< build_ext --inplace  && rm -rf $(PYDIR)/build
	python $< install --user && rm $(MDIR)/*.so



.PHONY: clean

clean:
	rm $(BLDDIR)/*.o $(LIBDIR)/*.a $(PYDIR)/*.c
	rm -rf $(BLDDIR)
	rm -rf $(LIBDIR)
	rm $(TOY)
	rm $(LOCALDIR)/pytoy*

# .base:
# 	if ! [ -e $(BLDDIR) ]; then mkdir $(BLDDIR) ; mkdir $(LIBDIR); fi;
# 	touch build/.base

# $(BLDDIR)/toy_module.o: $(SRCDIR)/toy_module.c $(IDIR)/toy_module.h
# 	$(CC) -c $< -o $@  -I $(IDIR)

# $(LIBDIR)/libtoy_module.a: $(BLDDIR)/toy_module.o
# 	ar rcs $@ $^

# $(PYDIR)/pytoy: $(PYDIR)/setup.py $(PYDIR)/pytoy.pyx $(LIBDIR)/libtoy_module.a
# 	python $< build_ext --inplace  && rm -rf $(PYDIR)/build
# 	python $< install --user && rm $(MDIR)/*.so
