======================
Cookiecutter PyPackage Rust Cross-Platform Publish
======================

Cookiecutter_ template for a Python package with a Rust binary module. 

Rust is a new systems programming language that is comparable in speed with C/C++; 
but it also has lots of nice modern features like memory safety, a package manager, 
and a sophisticated type system. 

Like C/C++, Rust can be called from Python. The goal of the project is to make 
it easy to start a Python project that includes a binary module written in Rust. 
A very important goal of the project is that it be able to produce a binary 
distribution (Wheel) which will not require the end user to actually compile 
the Rust code themselves. 

An example output of this cookiecutter can be seen at rust_pypi_example_. 
In the example I wrote a cli in Python that interops via CFFI with a Rust binary.
I used a tool called setuptools-rust which enables setuptools to handle compiling 
just like it would with C.

A binary wheel is produced for Linux and OSX by TravisCI_. A windows wheel is built 
for Windows with appveyor_. 


Supported platforms
-----------------------------
* manylinux_X86_64 and manylinux_i686
* OSX 
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
.. _rust_pypi_example: https://github.com/mckaymatt/rust_pypi_example

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
This depends on you having ``Make``, ``virtualenv``, and the Rust compiler. Get the Rust compiler from Rustup_

I will also mention that the Makefile workflow doesn't quite work on Windows yet, but it's still pretty easy 
to get going. You basically make a virtualenv, install the dev dependencies and run ``python setup.py test|install|bdist_wheel|develop`` depending on what you want to do.

Still with me? Okay, you are now ready to build your first Rust wheel locally. 
Go into the directory that Cookiecutter just created and perform your first build locally with:

    make local-test

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
