from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize
import numpy
import os
import subprocess as sbp
import os.path as osp

root_folder = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")

toy_extension = Extension(name='pytoy',
                          sources=['python/pytoy.pyx'],
                          libraries=['toy'],
                          library_dirs=['build/lib'],
                          include_dirs=['include',
                                        numpy.get_include()])

setup(author='Hongbo Cai',
      author_email='hoc34@pitt.edu',
      name='pytoy',
      ext_modules=cythonize([toy_extension]))
