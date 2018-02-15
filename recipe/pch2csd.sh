# pch2csd.sh
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
#sudo apt-get install -y --no-install-recommends 
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/gleb812/pch2csd.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd pch2csd
	sudo python3 setup.py install
	zynth_build_request ready 
	cd ..
fi
