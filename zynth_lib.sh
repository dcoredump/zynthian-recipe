#!/bin/sh

function zynth_git {
    tmp=`basename ${1}`
    repo_dir=`basename ${tmp} .git`
    if [ -d "${repo_dir}" ]
    then
        cd "${repo_dir}"
        git pull
        cd ..
    else
        git clone "${1}"
    fi
}

function zynth_svn {
    tmp=`basename ${1}`
    repo_dir=`basename ${tmp} -code`
    if [ -d "${repo_dir}" ]
    then
        cd "${repo_dir}"
        svn update
        cd ..
    else
        svn checkout "${1}" "${repo_dir}"
    fi
}
