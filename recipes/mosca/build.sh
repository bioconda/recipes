dir="${PREFIX}/share/MOSCA"
mkdir -p "${dir}/scripts" "${dir}/Databases" "${PREFIX}/bin"
cp scripts/* "${dir}/scripts"
cp -r Databases "${dir}/Databases"
chmod +x "${dir}/scripts/mosca.py"
ln -s "${dir}/scripts/mosca.py" "${PREFIX}/bin/"
