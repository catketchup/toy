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

INPARAM.H = $(IDIR)/inparam.h
PSPEC.H = $(IDIR)/pspec.h
TOY.H = $(IDIR)/toy.h

INPARAM.C = $(SRCDIR)/inparam.c
PSPEC.C = $(SRCDIR)/pspec.c
TOY.C = $(MAINDIR)/toy.c

INPARAM.O = $(BLDDIR)/inparam.o
PSPEC.O = $(BLDDIR)/pspec.o
TOY.O = $(BLDDIR)/toy.o

TOY = $(MDIR)/toy

# default: $(PYDIR)/pytoy
default: $(TOY)

$(INPARAM.O): $(INPARAM.C) $(INPARAM.H)
	$(CC) -c $(INPARAM.C) -o $@  -I $(IDIR)

$(PSPEC.O): $(PSPEC.C) $(INPARAM.H) $(PSPEC.H)
	$(CC) -c $(PSPEC.C) -o $@  -I $(IDIR)

$(LIBDIR)/libtoy.a: $(INPARAM.O) $(PSPEC.O)
	ar rcs $@ $(INPARAM.O) $(PSPEC.O)

$(TOY.O): $(TOY.C) $(INPARAM.C) $(PSPEC.C) $(INPARAM.H) $(PSPEC.H) $(TOY.H)
	$(CC) -c $(TOY.C) -o $@  -I $(IDIR)

$(TOY): $(TOY.O) $(PSPEC.O) $(TOY.H) $(PSPEC.H)
	$(CC) $(TOY.O) $(INPARAM.O) $(PSPEC.O) -o $(TOY)

$(PYDIR)/pytoy: $(PYDIR)/setup.py $(PYDIR)/pytoy.pyx $(LIBDIR)/libtoy.a
	python $< build_ext --inplace  && rm -rf $(PYDIR)/build
	python $< install --user && rm $(MDIR)/*.so



.PHONY: clean

clean:
	rm $(BLDDIR)/*.o $(LIBDIR)/*.a $(PYDIR)/*.c
	rm -rf $(BLDDIR)
	rm -rf $(LIBDIR)
	rm $(TOY)
	rm $(LOCALDIR)/pytoy*
