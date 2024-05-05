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

# SneakerNet depends on plugins in the SneakerNet.plugins
# subdirectory. Hack this path by just providing a symlink
ln -sv ${PREFIX}/bin ${PREFIX}/SneakerNet.plugins

# Need to keep the conf.bak and copy it to 
# the working copy conf.
cp -r config.bak ${PREFIX}/config.bak
cp -r config.bak ${PREFIX}/config
#sed -i 's+/opt/kraken/full-20140723+/kraken-database+g' ${PREFIX}/config/settings.conf
cat config.bak/settings.conf | \
  sed '/KRAKEN_DEFAULT_DB/d' > config/settings.conf

KALAMARI_VER=$(downloadKalamari.pl --version)
KRAKEN_DEFAULT_DB="${PREFIX}/share/kalamari-${KALAMARI_VER}.kraken1"
echo "KRAKEN_DEFAULT_DB = $KRAKEN_DEFAULT_DB" >> config/settings.conf

chmod 775 ${PREFIX}/bin/*
export PERL5LIB=$PERL5LIB:${PREFIX}/lib/perl5

echo
echo ======
echo "new PERL5LIB: $PERL5LIB"
perl -MData::Dumper -e 'print Dumper \@INC;'
echo ======
echo

