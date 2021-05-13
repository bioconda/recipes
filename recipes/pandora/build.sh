#!/bin/bash
set -eux -o pipefail

# make compilation not be dependent on locale settings
export LC_ALL=C

# installs make_prg
wget https://github.com/leoisl/make_prg/releases/download/v0.2.0/make_prg_0.2.0 -O "$PREFIX"/make_prg
sha256sum --check <(echo "193347b22775ece7065b20f258899b1afbee5ab91c34a7e86d43f00e307bf29a  $PREFIX/make_prg")

# # allows boost to find the correct build toolset in Linux
# BIN_DIR=$(which x86_64-conda-linux-gnu-gcc)
# BIN_DIR="$(dirname "${BIN_DIR}")"
# cp "${BIN_DIR}/x86_64-conda-linux-gnu-gcc" "${BIN_DIR}/gcc"
# cp "${BIN_DIR}/x86_64-conda-linux-gnu-g++" "${BIN_DIR}/g++"

# # build pandora
# mkdir -p build
# cd build
# cmake -DBIOCONDA=True \
#       -DCMAKE_BUILD_TYPE=Release \
#       -DHUNTER_JOBS_NUMBER=4 \
#       -DCMAKE_INSTALL_PREFIX="$PREFIX" \
#       ..
# make -j1  # Note: don't change this, or Bioconda Circle CI will error out with "OSError: [Errno 12] Cannot allocate memory"

# # test - 25 tests are excluded due to an unknown error that just happens in Bioconda Circle CI
# cd test
# ./pandora_test --gtest_filter=-FindPathsThroughCandidateRegionTest.endKmerExistsInStartKmersFindPathAndCycles:FindPathsThroughCandidateRegionTest.doGraphCleaningtwoIdenticalReadsPlusNoiseReturnOnePath:FindPathsThroughCandidateRegionTest.twoIdenticalReadsReturnOnePath:FindPathsThroughCandidateRegionTest.twoPossiblePathsOneWithLowCovgOnOneReturnsOnePath:FindPathsThroughCandidateRegionTest.twoPossiblePathsWithGoodCovgReturnsTwoPaths:GetNodeFromGraph.LowestKmerOfNode_KmerFoundInGraphAndNeighbour:GetNodeFromGraph.HighestKmerOfNode_KmerFoundInGraph:GetNodeFromGraph.HighestKmerOfNode_KmerFoundInGraphAndNeighbour:GetNodeFromGraph.LowestKmerOfStartNode_KmerFoundInGraphButNotNeighbourOfStart:GetNodeFromGraph.RevcompKmerOfInitialSeq_KmerFoundInGraphAndCorrectNeighbourFound:GetNodeFromGraph.NonExistentKmer_NotFoundInGraphAndNodeEmpty:GetPathsBetweenTest.OnlyReturnPathsBetweenStartAndEndKmers:GetPathsBetweenTest.lotsOfHighCovgCyclesReturnEmpty:DepthFirstSearchFromTest.SimpleGraphTwoNodesReturnSeqPassedIn:DepthFirstSearchFromTest.SimpleGraphSixNodesReturnSeqPassedIn:DepthFirstSearchFromTest.TwoReadsSameSequenceReturnOneSequence:DepthFirstSearchFromTest.TwoReadsOneVariantReturnOriginalTwoSequences:DepthFirstSearchFromTest.ThreeReadsTwoVariantsReturnOriginalSequences:DepthFirstSearchFromTest.TwoReadsTwoVariantsReturnOriginalTwoSequencesPlusTwoMosaics:DepthFirstSearchFromTest.ThreeReadsOneReverseComplimentReturnPathsForStrandOfStartAndEndKmers:DepthFirstSearchFromTest.SimpleCycleReturnPathsOfLengthsUpToMaxPathLengthCycling:GraphCleaningTest.simpleTipRemove:QueryAbundance.oneKmer_ReturnOne:QueryAbundance.twoKmers_ReturnTwo:QueryAbundance.fakeKmer_ReturnZero --gtest_color=no
# cd ..

# # TODO: test sample example

# # install
# make install
