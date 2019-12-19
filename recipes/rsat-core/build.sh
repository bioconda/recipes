

RSAT_DEST="$PREFIX/opt/rsat/"
mkdir -p "$RSAT_DEST"

cp -a perl-scripts python-scripts makefiles bin/rsat share/rsat/rsat.yaml "$RSAT_DEST"

# Build and dispatch compiled binaries
cd contrib
# for dbin in *
for dbin in info-gibbs count-words matrix-scan-quick retrieve-variation-seq variation-scan 
do
    if [ -d "$dbin" ]; then
        cd "$dbin"
        make clean && make CC=$CC CXX=$CXX && cp "$dbin" "$PREFIX/bin"
        cd ..
    fi
done


# TODO: R packaging
