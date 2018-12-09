# noice
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/falkTX/nooice.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd nooice
	make
	sudo make install
	sudo install-systemd
	zynth_build_request ready 
	make clean
	cd ..
fi
