#!/bin/bash
set -e -x

echo $HOSTUSER

function RETURNOWNERSHIP {
    chown -Rf --reference=/io/setup.py /io/wheelhouse /root/.cache/pip 
}
trap RETURNOWNERSHIP EXIT

function main() {
    chown -fR root:root /root/.cache/pip 
    rm -rf /io/wheelhouse


    # DELETE THIS 

    rm -rf /opt/python/cp26-* 
    rm -rf /opt/python/cp33-*
    rm -rf /opt/python/cp34-*
    rm -rf /opt/python/cp35-*



    # Compile wheels {cp27*,cp3*}
    for PYBIN in /opt/python/{cp27*,cp3*}/bin/; do
        # "${PYBIN}/pip" uninstall -y auditwheel
        "${PYBIN}/pip" install -U pip virtualenv
        # sleep 10000
        "${PYBIN}/virtualenv" /tmp/$PYBIN
        source "/tmp${PYBIN}/bin/activate"
        pip install -U pip
        pip install -r /io/requirements_dev.txt
        pip wheel /io/ -w /io/wheelhouse/
        deactivate
    done

    # Bundle external shared libraries into the wheels
    # for whl in /io/wheelhouse/*.whl; do
    #     auditwheel show "$whl" 
    #     auditwheel repair "$whl" -w /io/wheelhouse/
    # done

    # Install packages and test
    for PYBIN in /opt/python/{cp27*,cp3*}/bin/; do
        source "/tmp${PYBIN}/bin/activate"
        "${PYBIN}/pip" install {{cookiecutter.project_slug}} --no-index -f /io/wheelhouse
        # "${PYBIN}/pip" install  --no-index -f /io/wheelhouse
        sleep 10000
        # make test
        {% if cookiecutter.use_pytest == 'y' -%}
            py.test /io/tests/
        {% else %}
            python setup.py test
        {%- endif %}
        deactivate
    done
}



main 
RETURNOWNERSHIP