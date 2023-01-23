from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

toy_extension = Extension(
    name='pytoy',
    sources=['pytoy.pyx'],
    libraries=['toy_module'],
    library_dirs=['../lib'],
    include_dirs=['../include']
)

setup(
    name='pytoy',
    ext_modules=cythonize([toy_extension])
)
