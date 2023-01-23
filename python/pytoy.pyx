cdef extern from "toy_module.h":
    int toy_function(int a, int b)

def pytoy_function(a, b):
    return toy_function(a, b)
