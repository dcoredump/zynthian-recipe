# mod-python3-lilvlib.sh
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get -y --install-recommends --no-install-suggests install devscripts
sudo apt-get -y --no-install-recommends install python3-all-dev
sudo apt-get -y purge at cron exim4-base exim4-config exim4-daemon-light bsd-mailx
cd $ZYNTHIAN_SW_DIR
zynth_git https://github.com/dcoredump/lilvlib.git
if [ ${?} -ne 0 -o  "x${build}" != "x" ]
then
	zynth_build_request clear
	cd lilvlib
    if [ "${build}" = "clean" ]
    then
       rm -rf /usr/tmp/python3-lilv-build/
    fi
	./build-python3-lilv.sh
    dpkg -i python3-lilv_0.22.1+git20170620_armhf.deb
	zynth_build_request ready
    rm -r /usr/tmp/python3-lilv-build/
	cd ..
fi
