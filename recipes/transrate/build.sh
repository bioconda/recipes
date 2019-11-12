#!/bin/bash
set -x
mkdir -p ${PREFIX}/bin
gem build transrate.gemspec
gem install -n ${PREFIX}/bin transrate
ruby ${PREFIX}/bin/transrate --install-deps ref
gem install io-console -v 0.4.6
