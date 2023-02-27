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

    double add(double a, double b)

cdef extern from "pspec.h":
    cdef struct pspec:
        int cl_size
        double * cl

    int calculate_pspec(void * pinparam, void * ppspec)
    int calculate_exp_pspec(void * pinparam, double * incl, void * ppspec)
    int test_ndarray(void * pinparam, int nmap, double * incl, void * ppspec)

class Test_Compute:
    def __init__(self, a, b):
        self.a = a
        self.b = b

    def greet(self):
        print('Hello, NN!')

    def add(self):
        return add(self.a, self.b)

cdef class Compute:
    cdef inparam * pinparam
    cdef pspec * ppspec
    cdef int computed
    cdef int allocated

    def __cinit__(self, default=False):
        self.computed = False
        self.allocated = False
        self.pinparam = <inparam*> calloc(3, sizeof(double))
        self.ppspec = <pspec*> calloc(2, sizeof(double))

    def set(self, *args, **kwargs):
        self.pinparam.cl_size = kwargs['cl_size']
        self.pinparam.norm = kwargs['norm']
        self.pinparam.factor = kwargs['factor']

    def calculate_pspec(self):
        calculate_pspec(self.pinparam, self.ppspec)

        cl = np.zeros(self.pinparam.cl_size, dtype=np.double)

        for ell in range(self.pinparam.cl_size):
            cl[ell] = self.ppspec.cl[ell]

        output = {'ell':np.arange(self.pinparam.cl_size), 'Cl':cl}
        return output

    def calculate_exp_pspec(self, double[:] incl):
        calculate_exp_pspec(self.pinparam, &incl[0], self.ppspec)

        cl = np.zeros(self.pinparam.cl_size, dtype=np.double)

        for ell in range(self.pinparam.cl_size):
            cl[ell] = self.ppspec.cl[ell]

        return {'ell':np.arange(self.pinparam.cl_size), 'Cl':cl}

    def test_ndarray(self, nmap, double[:,:,::1] incl):
        test_ndarray(self.pinparam, nmap, &incl[0,0,0], self.ppspec)

        cl = np.zeros(nmap*nmap*self.pinparam.cl_size, dtype=np.double)

        for i in range(nmap*nmap*self.pinparam.cl_size):
            cl[i] = self.ppspec.cl[i]

        return cl

    # def test_pyobject(self):
    #     # cdef double *ptr=[1,2,3]
    #     # cdef double ptr=1
    #     cdef np.ndarray[np.float64_t, ndim=1] cov
    #     cov = np.zeros(10)

    #     return cov

    # def test_return_Cpointer(self, double[:] incl):
    #     calculate_exp_pspec(self.pinparam, &incl[0], self.ppspec)

    #     return self.self.ppspec.cl


    def get_cl_size(self):
        print(self.pinparam.cl_size)
