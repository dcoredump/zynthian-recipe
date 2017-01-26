#!/bin/sh

zynth_build_request () {
	project=${1}
	flag=${2}
	if [ "${flag}" = "clear" ]
	then
		rm -f "${ZYNTHIAN_SW_BUILD_DIR}/${project}_build"
	elif [ "${flag}" = "ready" ]
	then
		touch "${ZYNTHIAN_SW_BUILD_DIR}/${project}_build"
	fi
}

if [ "${1}" = "build" ]
then
	shift
	build="build"
	zynth_build_request ${0} clear
fi

if [ ! -d "${ZYNTHIAN_SW_DIR}/.build" ]
then
	mkdir "${ZYNTHIAN_SW_DIR}/.build"
fi
ZYNTHIAN_SW_BUILD_DIR="${ZYNTHIAN_SW_DIR}/.build"

machine=`uname -m 2>/dev/null || echo unknown`
if [ "${machine}" = "armv7l" ]
then
    model=cat /sys/firmware/devicetree/base/model 2>/dev/null || echo unknown
    if echo ${model} | egrep -Eq '[3]'
    then
        CPU="-mcpu=cortex-a53"
        FPU="-mfpu=neon-fp-armv8"
    else
        CPU="-mcpu=cortex-a7 -mthumb"
        FPU="-mfpu=neon-vfpv4"
    fi
    FPU="${FPU} -mneon-for-64bits"
fi
export CFLAGS="${CPU} ${FPU}"
export CXXFLAGS=${CFLAGS}

zynth_git () {
    ret=0

    if [ ${2} ]
    then
        tmp=`basename ${2}`
    else
        tmp=`basename ${1}`
    fi

    tmp=`basename ${1}`
    repo_dir=`basename ${tmp} .git`
    if [ -d "${repo_dir}" ]
    then
        cd "${repo_dir}"
        git pull 2>&1 | grep "Already up-to-date."
        if [ ${?} -eq 1 ]
	then
		ret=1
	fi
        cd ..
    else
        git clone "${1}"
        ret=1
    fi

    return ${ret}
}

zynth_git_recursive () {
    ret=0

    if [ ${2} ]
    then
        tmp=`basename ${2}`
    else
        tmp=`basename ${1}`
    fi

    tmp=`basename ${1}`
    repo_dir=`basename ${tmp} .git`
    if [ -d "${repo_dir}" ]
    then
        cd "${repo_dir}"
        git pull 2>&1 | grep "Already up-to-date."
        if [ ${?} -eq 1 ]
	then
		ret=1
	fi
        cd ..
    else
        git clone --recursive "${1}"
        ret=1
    fi

    return ${ret}
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

quote_path () {
    echo ${1} | sed 's/\//\\\//g'
}
