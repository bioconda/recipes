#!/bin/bash

# fail on all errors
set -e

export INCLUDES="-I${PREFIX}/include"
export LIBPATH="-L${PREFIX}/lib"
export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"

mkdir -p "${PREFIX}/bin"
mkdir -p "${PREFIX}/lib/perl5/site_perl/canu"

cp -rfv src/pipelines/canu/*.pm "${PREFIX}/lib/perl5/site_perl/canu"

cd src
make CC="${CC}" CXX="${CXX} -O3 -I${PREFIX}/include" -j"${CPU_COUNT}"

cd ../build/bin
install -v -m 0755 canu canu-time draw-tig canu.defaults dumpBlob ovStoreBuild ovStoreConfig ovStoreBucketizer \
	ovStoreSorter ovStoreIndexer ovStoreDump ovStoreStats sqStoreCreate sqStoreDumpFASTQ sqStoreDumpMetaData \
	tgStoreCompress tgStoreDump tgStoreLoad tgTigDisplay loadCorrectedReads loadTrimmedReads loadErates \
	seqrequester meryl overlapInCore overlapInCorePartition overlapConvert overlapImport overlapPair \
	edalign mhapConvert mmapConvert filterCorrectionOverlaps generateCorrectionLayouts filterCorrectionLayouts \
	falconsense errorEstimate splitHaplotype trimReads splitReads mergeRanges overlapAlign findErrors \
	fixErrors findErrors correctOverlaps bogart layoutReads utgcns layoutToPackage alignGFA "${PREFIX}/bin"
