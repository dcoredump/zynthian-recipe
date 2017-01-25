#!/bin/sh

<<<<<<< HEAD
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

=======
zynth_git () {
>>>>>>> 0ae6349b3c50ba7ae2d586046dba36dd2b473e59
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

zynth_svn () {
<<<<<<< HEAD
    ret=0

    if [ ${2} ]
    then
        tmp=`basename ${2}`
    else
        tmp=`basename ${1}`
    fi
=======
    tmp=`basename ${1}`
>>>>>>> 0ae6349b3c50ba7ae2d586046dba36dd2b473e59
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
