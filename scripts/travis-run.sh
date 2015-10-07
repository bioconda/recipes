#!/bin/bash
set -e

if [[ $TRAVIS_OS_NAME = "linux" ]]
then
    # run CentOS5 based docker container
    docker run -e TRAVIS_BRANCH -e TRAVIS_PULL_REQUEST -e ANACONDA_TOKEN -e CONDA_PY -e CONDA_NPY -v `pwd`:/bioconda-recipes bioconda/bioconda-builder
else
    export PATH=/tmp/anaconda/bin:$PATH
    # build packages
    scripts/build-packages.py --repository . --packages `cat osx-whitelist.txt`
fi
