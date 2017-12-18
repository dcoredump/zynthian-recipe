apt-get -y --no-install-recommends install libcurl3-dev libpng-dev libssl-dev flex bison libxcb1-dev libsdl1.2-dev
mkdir -p ${HOME}/netsurf/workspace
cd ${HOME}/netsurf/workspace
cat > env.sh <<'EOF'
export PKG_CONFIG_PATH=${HOME}/netsurf/workspace/inst/lib/pkgconfig
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${HOME}/netsurf/workspace/inst/lib
export PREFIX=${HOME}/netsurf/workspace/inst
export PATH="${PREFIX}/bin:${PATH}"
EOF
export PKG_CONFIG_PATH=${HOME}/netsurf/workspace/inst/lib/pkgconfig
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${HOME}/netsurf/workspace/inst/lib
export PREFIX=${HOME}/netsurf/workspace/inst
export PATH="${PREFIX}/bin:${PATH}"
mkdir inst
cd inst
for i in buildsystem libparserutils libwapcaplet libhubbub libcss libnsgif libnsbmp librosprite libnsfb libdom libnsutils libutf8proc nsgenbind
do
	git clone --recursive git://git.netsurf-browser.org/$i
	cd $i
	make install
	cd ..
done
cd ..
git clone --recursive git://git.netsurf-browser.org/netsurf
cd netsurf
make TARGET=framebuffer
