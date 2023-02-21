MDIR := $(shell pwd)
IDIR = $(MDIR)/include
SRCDIR = $(MDIR)/source
MAINDIR = $(MDIR)/main
LOCALDIR :=$(shell python -m site --user-site)

BLDDIR = $(MDIR)/build
LIBDIR = $(BLDDIR)/lib
PYDIR = $(MDIR)/python

# .base:
# 	if ! [ -e $(BLDDIR) ]; then mkdir $(BLDDIR) ; mkdir $(LIBDIR); fi;
# 	touch build/.base

$(shell if [ ! -e $(BLDDIR) ];then mkdir $(BLDDIR); mkdir $(LIBDIR); fi)

CC = gcc

default: $(PYDIR)/pytoy

# $(BLDDIR)/toy_module.o: $(SRCDIR)/toy_module.c $(IDIR)/toy_module.h
# 	$(CC) -c $< -o $@  -I $(IDIR)

# $(LIBDIR)/libtoy_module.a: $(BLDDIR)/toy_module.o
# 	ar rcs $@ $^

# $(PYDIR)/pytoy: $(PYDIR)/setup.py $(PYDIR)/pytoy.pyx $(LIBDIR)/libtoy_module.a
# 	python $< build_ext --inplace  && rm -rf $(PYDIR)/build
# 	python $< install --user && rm $(MDIR)/*.so

TOY.H = $(IDIR)/toy.h
TOY_MODULE.H = $(IDIR)/toy_module.h

TOY.C = $(MAINDIR)/toy.c
TOY_MODULE.C = $(SRCDIR)/toy_module.c

TOY.O = $(BLDDIR)/toy.o
TOY_MODULE.O = $(BLDDIR)/toy_module.o

TOY = $(MDIR)/toy

# default: $(PYDIR)/pytoy
default: $(TOY)

$(TOY_MODULE.O): $(TOY_MODULE.C) $(TOY_MODULE.H)
	$(CC) -c $(TOY_MODULE.C) -o $@  -I $(IDIR)

$(LIBDIR)/libtoy_module.a: $(TOY_MODULE.O)
	ar rcs $@ $(TOY_MODULE.O)

$(TOY.O): $(TOY.C) $(TOY_MODULE.C) $(TOY.H) $(TOY_MODULE.H)
	$(CC) -c $(TOY.C) -o $@  -I $(IDIR)

$(TOY): $(TOY.O) $(TOY_MODULE.O) $(TOY.H) $(TOY_MODULE.H)
	$(CC) $(TOY.O) $(TOY_MODULE.O) -o $(TOY)

$(PYDIR)/pytoy: $(PYDIR)/setup.py $(PYDIR)/pytoy.pyx $(LIBDIR)/libtoy_module.a
	python $< build_ext --inplace  && rm -rf $(PYDIR)/build
	python $< install --user && rm $(MDIR)/*.so



.PHONY: clean

clean:
	rm $(LOCALDIR)/pytoy*
	rm $(BLDDIR)/*.o $(LIBDIR)/*.a $(PYDIR)/*.c
	rm -rf $(BLDDIR)
	rm -rf $(LIBDIR)
	rm $(TOY)
