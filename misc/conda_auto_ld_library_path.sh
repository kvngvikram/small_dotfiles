# from https://github.com/conda/conda/issues/12800#issuecomment-2121255566
conda_auto_ld () {
    ## PURPOSE: Contrive to create/modify 'Activation/deactivation
    ## scripts' for a conda environment to automatically set/reset
    ## LD_LIBRARY_PATH by prepending its lib directory to
    ## LD_LIBRARY_PATH.  $1 is the optional environment prefix needing
    ## these scripts, defaulting to ${CONDA_PREFIX}.
    ##
    ## ASSUMES: this function will only be run once for any installed
    ## conda environment, since it modifies any pre-existing scripts.
    ##
    ## AUTHOR: malcolm_cook@stowers.org
    conda_prefix=${1-${CONDA_PREFIX:?must be set if not supplied as parameter to conda_auto_ld}}
    [ -w ${conda_prefix} ] || 
	{ printf 'ERROR: conda_prefix [%s] must exist and be writable (in conda_auto_ld)\n' ${conda_prefix}; return;  }
    [ -d ${conda_prefix}/lib ] || 
	{ printf 'ERROR: conda_prefix [%s] lacks required /lib subdirectory (in conda_auto_ld)\n' ${conda_prefix}; return;  }
    condalib=${conda_prefix}/lib
    mkdir -p ${conda_prefix}/etc/conda/{de,}activate.d # which may (not?) already exist!
    printf '#ADDED BY: conda_auto_ld:\nexport LD_LIBRARY_PATH='${condalib}'${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}\n' > \
	   ${conda_prefix}/etc/conda/activate.d/env_vars.sh
    printf '#ADDED BY: conda_auto_ld:\nLD_LIBRARY_PATH=${LD_LIBRARY_PATH/'${condalib@Q}'/}\nLD_LIBRARY_PATH=${LD_LIBRARY_PATH#:}\n' > \
	   ${conda_prefix}/etc/conda/deactivate.d/env_vars.sh
	echo "Created ${conda_prefix}/etc/conda/{de,}activate.d/env_vars.sh files"
}
