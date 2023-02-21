from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

toy_extension = Extension(
    name='pytoy',
    sources=['python/pytoy.pyx'],
    libraries=['ps'],
    library_dirs=['build/lib'],
    include_dirs=['include']
)

setup(
    author='Hongbo Cai',
    author_email='hoc34@pitt.edu',
    name='pytoy',
    ext_modules=cythonize([toy_extension])

)
