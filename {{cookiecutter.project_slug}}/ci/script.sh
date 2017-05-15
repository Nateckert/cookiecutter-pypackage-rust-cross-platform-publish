# This script takes care of testing your crate

set -ex

main() {
    # move into rust project subdir
    pushd {{cookiecutter.project_slug}}/rust/
    cross build --target $TARGET
    cross build --target $TARGET --release

    # disable tests
    if [ ! -z $DISABLE_TESTS ]; then
        echo "Rust Tests Disabled"
    else
        cross test --target $TARGET
        cross test --target $TARGET --release
    fi
    # uncomment if creating a bin
    # cross run --target $TARGET
    # cross run --target $TARGET --release

    # hack 
    # move target/$TARGET/release to target/release to make
    # it easier to locate for py dist. See {{cookiecutter.project_slug}}.py
    if [ ! -d "target/$TARGET/release" ]; then
        echo "Cannot find release dir at target/$TARGET/release"
        exit 2
    else
        pushd target
        mv release release.bak || true
        ln -s $TARGET/release release
        popd
    fi
    popd
}

pymain_linux() {
    # cache pip packages used in docker
    mkdir -p ~/.manylinux_pip_cache
    # SUB='-v /home/matt/workspace/auditwheel/auditwheel/wheeltools.py:/opt/python/cp36-cp36m/lib/python3.6/site-packages/auditwheel/wheeltools.py'
    docker run --rm -e HOSTUSER=`id -un` $SUB -v ~/.manylinux_pip_cache:/root/.cache/pip \
        -v `pwd`:/io quay.io/pypa/manylinux1_x86_64 /io/ci/manylinux_build_wheel.sh
    # chown  -fR "`id -un`:`id -gn`" wheelhouse ~/.manylinux_pip_cache
    # source .venv/bin/activate
    # python setup.py bdist_wheel

    # make test
    # make lint
    # make coverage
    # make docs
}

pymain_osx() {
    source .venv/bin/activate
    python setup.py bdist_wheel

}

if [ -z ${TARGET+x} ]; then
    if [ ! -z ${TRAVIS_BUILD_NUMBER+x} ]; then
        echo "Target not set but it looks like this is running on Travis."
        exit 2
    fi
    echo "TARGET is not set. Defaulting to x86_64-unknown-linux-gnu"
    export TARGET='x86_64-unknown-linux-gnu'
    # This is for local testing. You can change the default to match your system.

else 
    echo "TARGET is $TARGET"
fi





main
if [ $TRAVIS_OS_NAME = "osx" ]; then
    pymain_osx
else
    pymain_linux
fi