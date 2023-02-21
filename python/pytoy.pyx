cdef extern from "toy_module.h":
    double add(double a, double b)

class Compute:
    def __init__(self, a, b):
        self.a = a
        self.b = b

    def greet(self):
        print('Hello, Niuniu!')

    def food(self):
        print("potato, broccoli, lotus root")

    def add(self):
        return add(self.a, self.b)


# cdef class Compute:
#     def __cinit__(self, default=False):
