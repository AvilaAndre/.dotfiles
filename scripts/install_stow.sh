#!/bin/bash

STOW_DOWNLOAD_LINK="http://ftp.gnu.org/gnu/stow/stow-latest.tar.gz"


 path_to_stow_executable=$(which stow)
 if [ -x "$path_to_stow_executable" ] ; then
    echo "stow already exists: $path_to_stow_executable"
    exit
 fi

curl -fOJ $STOW_DOWNLOAD_LINK && \
	tar xf stow-latest.tar.gz --one-top-level=stow_folder && \
	mv stow_folder/* deps/stow/ && \
	rm stow-latest.tar.gz && \
	rm -rf stow_folder

cd deps/stow/ && ./configure && sudo make install && cd ..

echo "INSTALL: stow installed in deps/"
