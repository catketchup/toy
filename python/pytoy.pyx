cdef extern from "toy_module.h":
    int toy_function(int a, int b)

class Compute:
    def __init__(self, a, b):
        self.a = a
        self.b = b

    def greet(self):
        print('Hello, Niuniu!')

    def food(self):
        print("potato, broccoli, lotus root")

    def add(self):
        return toy_function(self.a, self.b)


# cdef class Compute:
#     def __cinit__(self, default=False):
