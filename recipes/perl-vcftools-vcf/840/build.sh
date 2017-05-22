#!/bin/bash
set -eu

mkdir -p perl-lib/lib
cp perl/*.pm perl-lib/lib
# Fix version to something cpan installable tools like
sed -i.bak 's/r840/0.840/' perl-lib/lib/Vcf.pm
# Fix naming scheme of package to make Builder happy
sed -i.bak 's/Vcf.pm.  Module/Vcf - Module/' perl-lib/lib/Vcf.pm
cp $RECIPE_DIR/Build.PL perl-lib
cd perl-lib
cpanm -v -i .
