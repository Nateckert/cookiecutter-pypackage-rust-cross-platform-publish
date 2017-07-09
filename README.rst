==================================================
Cookiecutter PyPackage Rust Cross-Platform Publish
==================================================

Cookiecutter_ template for building and releasing Python packages with a Rust binary module. 
Supports Linux, macOS and Windows.

Rust is a new systems programming language that is comparable in speed with C/C++; 
but it also has lots of nice modern features like memory safety, a package manager, 
and a sophisticated type system. 

Like C/C++, Rust can be called from Python. The goal of the project is to make 
it easy to start a Python project that includes a binary module written in Rust. 
A very important goal of the project is that it be able to produce a binary 
distribution (Wheel) which will not require the end user to actually compile 
the Rust code themselves. 

A binary wheel is produced for Linux and OSX by TravisCI_. A windows wheel is built 
for Windows with appveyor_. 

Example Output
--------------

An exmple project made by this cookiecutter can be seen on github at mckaymatt/rust_pypi_example_. 
In the example I wrote a cli in Python that interops via CFFI with a Rust binary.
I used a tool called PyO3/setuptools-rust_ which enables setuptools to handle compiling 
just like it would with C.

The binary wheels can be seen on Pypi at pypi.python.org/pypi/rust-pypi-example_. 
You should be able to install the package on your platform with::

    pip install rust_pypi_example
    # test if a number is prime
    rust_pypi_example 13
    
Please create an issue_ if you encounter any problems and include details about your platform.

Supported platforms
-------------------
* manylinux_X86_64 and manylinux_i686
* macOS/OSX 
* Windows

Features
--------
* manylinuyx support - see https://github.com/pypa/manylinux
* Testing setup performed via ``python setup.py test`` for either ``unittest`` or ``py.test``
* TravisCI_: Ready for Travis Continuous Integration testing
* Tox_ testing: Setup to easily test for Python 2.6, 2.7, 3.3, 3.4, 3.5
* Sphinx_ docs: Documentation ready for generation with, for example, ReadTheDocs_
* Bumpversion_: Pre-configured version bumping with a single command
* Auto-release to PyPI_ when you push a new tag to master (optional)
* Command line interface using Click (optional)

.. _Cookiecutter: https://github.com/audreyr/cookiecutter
.. _appveyor: https://www.appveyor.com/
.. _mckaymatt/rust_pypi_example: https://github.com/mckaymatt/rust_pypi_example
.. _PyO3/setuptools-rust: https://github.com/PyO3/setuptools-rust
.. _pypi.python.org/pypi/rust-pypi-example: https://pypi.python.org/pypi/rust-pypi-example
.. _issue: https://github.com/mckaymatt/cookiecutter-pypackage-rust-cross-platform-publish/issues/new

Quickstart
----------

Install the latest Cookiecutter if you haven't installed it yet (this requires
Cookiecutter 1.4.0 or higher)::

    pip install -U cookiecutter

Generate a Python package project::

    cookiecutter https://github.com/mckaymatt/cookiecutter-pypackage-rust-cross-platform-publish.git

Cookiecutter will prompt you to answer some questions about the project you want to create. 
After you finish answering the promps, the new project will be made. 


Local Development Workflow / Hello World
----------------------------------------
This depends on you having ``virtualenv``, and the Rust compiler. Get the Rust compiler from Rustup_. Linux/macOS 
users will also need ``Make``. 

**Linux/macOS**

The entire local process of building and testing (including 
creating and activating a virtualenv) is conducted by a single Make command::

    # cd to new project. The default name is rust_pypi_example
    cd rust_pypi_example
    make local-test

I will note that the virtualenv created by Make seems to have some issues if you try to activate it. 
If you want to work interactivly you should build your own virtualenv and use that instead. 

**Windows**

The Makefile workflow doesn't quite work on Windows yet, but it's still pretty easy 
to get going. You basically make a virtualenv, install the dev dependencies and run ``python setup.py test|install|bdist_wheel|develop`` depending on what you want to do.

Go into the directory that Cookiecutter just created (default is rust_pypi_example) and perform your 
first build locally with::

    # make a virtualenv and activate it
    pip install -U pip
    pip install -r requirements_dev.txt
    python setup.py build_ext     # compile ext
    python setup.py test          # test
    python setup.py bdist_wheel   # to make the wheel. Always build_ext first

W00t. You just tested, compiled and packaged you're first Python wheel with a Rust module. 

.. _Rustup: https://www.rustup.rs/

Set Up Cross-Platform CI, Build and Release
-------------------------------------------

* Create a repo for your new project locally and push it to GitHub.
* Add the repo to your TravisCI_ account.
* Install the dev requirements into a virtualenv. (``pip install -r requirements_dev.txt``)
* Run the script `travis_pypi_setup.py` to encrypt your PyPI password in Travis config
  and activate automated deployment on PyPI when you push a new tag to master branch.
* Add the repo to your ReadTheDocs_ account + turn on the ReadTheDocs service hook.
* Release your package by pushing a new tag to master.
* Add a `requirements.txt` file that specifies the packages you will need for
  your project and their versions. For more info see the `pip docs for requirements files`_.
* Activate your project on `pyup.io`_.

.. _`pip docs for requirements files`: https://pip.pypa.io/en/stable/user_guide/#requirements-files

Known Bugs
----------
If you don't run **build_ext** before **bdist_wheel**, the resulting wheel will not have the shared library
compiled by Cargo. In other words::

    # This alone will make a defective wheel
    python setup.py bdist_wheel

    # this will work
    python setup.py build_ext
    python setup.py bdist_wheel
    
TODOs
-----

[ ] source distributions.

For more details, see the `cookiecutter-pypackage tutorial`_.

.. _`cookiecutter-pypackage tutorial`: https://cookiecutter-pypackage.readthedocs.io/en/latest/tutorial.html


.. _TravisCI: http://travis-ci.org/
.. _Tox: http://testrun.org/tox/
.. _Sphinx: http://sphinx-doc.org/
.. _ReadTheDocs: https://readthedocs.io/
.. _`pyup.io`: https://pyup.io/
.. _Bumpversion: https://github.com/peritus/bumpversion
.. _PyPi: https://pypi.python.org/pypi

.. _`Nekroze/cookiecutter-pypackage`: https://github.com/Nekroze/cookiecutter-pypackage
.. _`tony/cookiecutter-pypackage-pythonic`: https://github.com/tony/cookiecutter-pypackage-pythonic
.. _`ardydedase/cookiecutter-pypackage`: https://github.com/ardydedase/cookiecutter-pypackage
.. _github comparison view: https://github.com/audreyr/cookiecutter-pypackage/compare/master...mckaymatt:master
.. _`network`: https://github.com/audreyr/cookiecutter-pypackage/network
.. _`family tree`: https://github.com/audreyr/cookiecutter-pypackage/network/members
