set -e
# This is used in github actions when building the wheels for distribution.
# DO NOT RUN THIS SCRIPT OUTSIDE OF THAT!!!
pip install lalsuite

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Needed for linux
    cp `python -c 'import sys; print (sys.path[-1])'`/lalsuite.libs/lib*so* /usr/lib
    ln -sf `python -c 'import sys; print (sys.path[-1])'`/lalsuite.*libs/liblal-*so* /usr/lib/liblal.so
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac names are quite different
    sudo cp `python -c 'import sys; print (sys.path[-1])'`/lalsuite.dylibs/lib*dylib /usr/local/lib
    sudo cp `python -c 'import sys; print (sys.path[-1])'`/lalsuite.dylibs/liblal.*.dylib /usr/local/lib/liblal.dylib
    # I don't understand why this directory is used at all. The code that does this is here:
    # https://github.com/matthew-brett/delocate
    sudo mkdir /DLC
    sudo chmod ugo+rwx /DLC
fi # Don't consider anything else at present
