mkdir -p ${PREFIX}/bin

cp STAR_to_cancer_introns.py ${PREFIX}/bin/
cp prep_genome_lib/ctat-splicing-lib-integration.py ${PREFIX}/bin

chmod +x ${PREFIX}/bin/STAR_to_cancer_introns.py
chmod +x ${PREFIX}/bin/ctat-splicing-lib-integration.py

ln -s ${PREFIX}/bin/STAR_to_cancer_introns.py ${PREFIX}/bin/STAR_to_cancer_introns
ln -s ${PREFIX}/bin/ctat-splicing-lib-integration.py ${PREFIX}/bin/ctat-splicing-lib-integration
