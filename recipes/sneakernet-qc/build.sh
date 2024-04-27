#!/bin/bash

which make
which perl
echo
echo ======
ls -RF
echo "PERL5LIB: $PERL5LIB"
echo ======
echo
perl Makefile.PL
make
make install

mkdir -p  ${PREFIX}/bin 
mkdir -pv ${PREFIX}/lib/perl5
cp -v SneakerNet.plugins/*.pl ${PREFIX}/bin/
cp -v SneakerNet.plugins/*.py ${PREFIX}/bin/
cp -v SneakerNet.plugins/*.sh ${PREFIX}/bin/
cp -v scripts/*.pl            ${PREFIX}/bin/
cp -v lib/perl5/SneakerNet.pm ${PREFIX}/lib/perl5
chmod 775 ${PREFIX}/bin/*
export PERL5LIB=$PERL5LIB:${PREFIX}/lib/perl5

echo
echo ======
echo "new PERL5LIB: $PERL5LIB"
echo ======
echo

