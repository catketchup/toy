from math import exp,log
import numpy as np
cimport numpy as np
from libc.stdlib cimport *
from libc.stdio cimport *
from libc.string cimport *
import cython
cimport cython

cdef extern from "inparam.h":
    cdef struct inparam:
        int cl_size
        double norm
        double factor

cdef extern from "pspec.h":
    cdef struct pspec:
        int cl_size
        double * cl

    double add(double a, double b)
    int calculate_pspec(void * pinparam, void * ppspec)

class Test_Compute:
    def __init__(self, a, b):
        self.a = a
        self.b = b

    def greet(self):
        print('Hello, Niuniu!')

    def food(self):
        print("potato, broccoli, lotus root")

    def add(self):
        return add(self.a, self.b)

cdef class Compute:
    cdef inparam * pinparam
    cdef pspec * ppspec
    cpdef int computed
    cpdef int allocated

    pinparam = <inparam*> calloc(sizeof(inparam))
    ppspec = <pspec*> calloc(sizeof(pspec))

    def __cinit__(self, default=False):
        self.computed = False
        self.allocated = False

    def set(self, *args, **kwargs):
        self.pinparam.cl_size = kwargs['cl_size']
        self.pinparam.norm = kwargs['norm']
        self.pinparam.factor = kwargs['factor']

    def calculate_pspec(self):
        calculate_pspec(self.pinparam, self.ppspec)
        cl = np.zeros(self.pinparam.cl_size+1, dtype=np.double)

        for ell in range(self.pinparam.cl_size):
            cl[ell] = self.ppspec.cl[ell]

        output = {'ell':np.arange(self.pinparam.cl_size+1), 'Cl':cl}
        return output

    def get_cl_size(self):
        print(self.pinparam.cl_size)
