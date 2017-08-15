# loopor
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/stevie67/loopor.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd loopor/loopor-lv2/source
	quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}/lv2`
	sed -i -- "s/PREFIX  ?= \/usr\/local/PREFIX  ?= ${quoted_ZYNTHIAN_PLUGINS_DIR}/" Makefile
	sed -i -- "s/\/lib\/lv2//" Makefile
	make
	sudo make install
	zynth_build_request ready 
	make clean
	cd ../../..
fi
