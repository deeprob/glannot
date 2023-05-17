#!/bin/bash
#SBATCH --account=girirajan # TODO: set account name
#SBATCH --partition=girirajan # TODO: set slurm partition
#SBATCH --job-name=glannot_prep 
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=400:0:0
#SBATCH --mem-per-cpu=10G
#SBATCH --chdir /data6/deepro/annot_cache # TODO: set dir to cache dir
#SBATCH -o /data6/deepro/annot_cache/slurm/logs/out_down.log # TODO: set slurm output file
#SBATCH -e /data6/deepro/annot_cache/slurm/logs/err_down.log # TODO: set slurm input file
#SBATCH --nodelist=sarah


echo `date` starting job on $HOSTNAME

cache_dir="/data6/deepro/annot_cache" # TODO: set cache dir path
glannot_image="/data6/deepro/annot_cache/glannot_latest.sif" # TODO: set glannot pulled image path

singularity exec --containall -H $cache_dir:/data -B $cache_dir:/data $glannot_image INSTALL.pl -a cf -s homo_sapiens -y GRCh38 --CACHEDIR /data

echo `date` ending job on $HOSTNAME
