#!/bin/bash

function helpTxt(){
	echo -e "\nDESCRIPTION:\n"
	echo -e "Run an instance of neuropointillist. Usually, you will want to use the"
	echo -e "singularity container option, but there are some cases where this is "
	echo -e "not possible (e.g., using non-containerized proprietary software)."
	echo -e "The working directory (specified with the -w flag) needs to have the "
	echo -e "readargs.R file. "
	echo -e "All data paths written in the readargs.R file should be relative to "
	echo -e "the <workdir> or the <datadir>, if specified"
	echo -e "If specifying a data directory that exists outside of the working "
	echo -e "directory AND using the singularity option, filepaths used in the "
	echo -e "neuropointillist commands should replace that data path with \'/data\'. "
	echo -e "(i.e., -d /my/data/dir; the filepath /my/data/dir/func.nii should be "
	echo -e " written as /data/func.nii within the readargs.R file)."
	echo -e "\nUSAGE:\n"
	echo -e "  ${BASH_SOURCE[0]} -w <workdir>"
	echo -e "  ${BASH_SOURCE[0]} -w <workdir> -d <datadir>"
	echo -e "\nOPTIONS WITH ARGUMENTS:\n"
	echo -e "  -w, --workdir     working directory for running analysis"
	echo -e "  -d, --datadir     data directory (if outside of working directory)"
	echo -e "\nOTHER OPTIONS:\n"
	echo -e "  -s, --singularity run neuropointillist through singularity container"
	echo -e "  -h, --help        display this help text\n"
	exit
}

singularity=0
while [[ $# -gt 0 ]]
do
	key="$1"
	case $key in
		-w|--workdir)
    workDir="$2"
    shift 2
    ;;
    -d|--datadir)
    dataDir="$2"
    shift 2
    ;;
		-s|--singularity)
		singularity=1
		shift
		;;
		-h|--help)
		helpTxt
		exit
		;;
		*)
		echo "invalid options given: $1. exiting..."
		exit
		;;
	esac
done

#get location of this script
scriptDir=$(cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P)
npointSif=$(realpath "${scriptDir}/../lib/neuropointillist.sif")

# if it's singularity, we need to specify the home directory as the workDir.
# if they specified a dataDir, we'll add that extra binding as well.
if [ "${singularity}" -eq 1 ]; then
	npointcmd="singularity run -H ${workDir} "
	if [ ! -z "${datadir+x}" ]; then
		npointcmd="${npointcmd} -B ${dataDir}:/data"
	fi
	npointcmd="${npointcmd} ${npointSif} npoint"

# otherwise, just move to the workDir and run npoint
else
	cd "${workDir}"
	npointcmd="npoint "
fi

# run npoint
echo "Running ${npointcmd}"
${npointcmd}
