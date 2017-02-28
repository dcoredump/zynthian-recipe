#!/bin/sh

###############################################################################
# GLOBAL VARS
###############################################################################

_git_options=""
PROJECT=`basename ${0} .sh`

###############################################################################
# FUNCTIONS
###############################################################################

quote_path () {
    echo ${1} | sed 's/\//\\\//g'
}

zynth_build_request () {
	flag=${1}
	if [ "x${flag}" = "xclear" ]
	then
		rm -f "${ZYNTHIAN_SW_BUILD_DIR}/${PROJECT}_build"
	elif [ "x${flag}" = "xready" ]
	then
		touch "${ZYNTHIAN_SW_BUILD_DIR}/${PROJECT}_build"
	fi
}

zynth_svn () {
    ret=0

    if [ ${2} ]
    then
        tmp=`basename ${2}`
    else
        tmp=`basename ${1}`
    fi
    repo_dir=`basename ${tmp} -code`

    if [ -d "${repo_dir}" ]
    then
        cd "${repo_dir}"
        svn update 2>&1 | grep "At revision"
        if [ ${?} -eq 1 ]
	then
		ret=1
	fi
        cd ..
    else
        svn checkout "${1}" "${repo_dir}"
        ret=1
    fi

    return ${ret}
}

zynth_git () {
    ret=0

    tmp=`basename ${1}`
    repo_dir=`basename ${tmp} .git`
    if [ -d "${repo_dir}" ]
    then
        cd "${repo_dir}"
        git_message=`git pull 2>&1`
        if [ ! `echo "${message}" | grep -Eq "up-to-date"` ]
	then
		zynth_build_request ready
        else
		ret=99
		zynth_build_request clear
	fi
        cd ..
    else
	if [ "x${_git_options}" = "x" ]
	then
            git clone "${1}"
	else
            git clone "${_git_options}" "${1}"
	fi
        ret=1
    fi

    return ${ret}
}

zynth_git_recursive () {
   _git_options="--recursive"
   ret=`zynth_git $*`
   return ${ret}
}

###############################################################################
# MAIN
###############################################################################

echo "PROJECT: $PROJECT"

if [ "${1}" = "build" ]
then
	shift
	build="build"
	zynth_build_request clear
elif [ "${1}" = "clean" ]
then
	shift
	build="clean"
	zynth_build_request clear
fi

if [ ! -d "${ZYNTHIAN_SW_DIR}/.build" ]
then
	mkdir "${ZYNTHIAN_SW_DIR}/.build"
fi
ZYNTHIAN_SW_BUILD_DIR="${ZYNTHIAN_SW_DIR}/.build"

machine=`uname -m 2>/dev/null || echo unknown`
if [ "${machine}" = "armv7l" ]
then
    model=`cat /sys/firmware/devicetree/base/model` 2>/dev/null || echo unknown
    if echo "${model}" | egrep -Eq '[3]'
    then
        CPU="-mcpu=cortex-a53"
        FPU="-mfpu=neon-fp-armv8"
    else
        CPU="-mcpu=cortex-a7 -mthumb"
        FPU="-mfpu=neon-vfpv4"
    fi
    FPU="${FPU} -mneon-for-64bits"
    export RASPI=true
    export CFLAGS="${CPU} ${FPU}"
    export CXXFLAGS="${CFLAGS}"
fi

