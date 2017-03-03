#/bin/bash

set -e

cd

if [[ -e $HOME/.bootstrapped ]]; then
  exit 0
fi

PYPY_VERSION=5.1.0

if [[ -e $HOME/pypy-$PYPY_VERSION-linux64.tar.bz2 ]]; then
  tar -xjf $HOME/pypy-$PYPY_VERSION-linux64.tar.bz2
  rm -rf $HOME/pypy-$PYPY_VERSION-linux64.tar.bz2
else
  # As for the following bitbucket download address is not accessible in china,
  # We use the the http server which has been setup on the control machine. Please
  # replace 172.16.73.121 will you own control machine's IP address.
  # wget -O - https://bitbucket.org/pypy/pypy/downloads/pypy-$PYPY_VERSION-linux64.tar.bz2 |tar -xjf -
  wget -O - http://172.16.73.121:8000/pypy-$PYPY_VERSION-linux64.tar.bz2 |tar -xjf -
fi

mv -n pypy-$PYPY_VERSION-linux64 pypy

## library fixup
mkdir -p pypy/lib
ln -snf /lib64/libncurses.so.5.9 $HOME/pypy/lib/libtinfo.so.5

mkdir -p $HOME/bin

cat > $HOME/bin/python <<EOF
#!/bin/bash
LD_LIBRARY_PATH=$HOME/pypy/lib:$LD_LIBRARY_PATH exec $HOME/pypy/bin/pypy "\$@"
EOF

chmod +x $HOME/bin/python
$HOME/bin/python --version

touch $HOME/.bootstrapped
