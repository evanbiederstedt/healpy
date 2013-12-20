#!/bin/env bash
cd build/lib*/healpy/test/data
. get_wmap_maps.sh
cd ../..
for lib in *.so
do
    echo "++++++++++++++++++++++++++++++++++++"
    echo $lib
    ldd $lib
    echo "++++++++++++++++++++++++++++++++++++"
done
echo "get_config_vars_start++++++++++++++++++++++++++++++++++++"
python -c "import pprint; import distutils.sysconfig; pprint.pprint(distutils.sysconfig.get_config_vars())"
echo "get_config_vars_stop++++++++++++++++++++++++++++++++++++"
nosetests -v --with-doctest
nosetests_returnvalue=$?
echo Run Cython extensions doctests
python run_doctest_cython.py
cython_doctest_returnvalue=$?
exit $(($nosetests_returnvalue + $cython_doctest_returnvalue))
