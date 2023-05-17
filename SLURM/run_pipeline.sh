#!/bin/bash
#SBATCH --account=girirajan # TODO: set account name
#SBATCH --partition=girirajan # TODO: set slurm partition
#SBATCH --job-name=glannot_prep 
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=400:0:0
#SBATCH --mem-per-cpu=10G
#SBATCH --chdir /data6/deepro/annot_cache # TODO: set dir to cache dir
#SBATCH -o /data6/deepro/annot_cache/slurm/logs/out_run.log # TODO: set slurm output file
#SBATCH -e /data6/deepro/annot_cache/slurm/logs/err_run.log # TODO: set slurm input file
#SBATCH --nodelist=sarah


echo `date` starting job on $HOSTNAME

cache_dir="/data6/deepro/annot_cache" # TODO: set cache dir path
input_dir="/data6/deepro/computational_pipelines/glannot/test/input" # TODO: set input dir path
output_dir="/data6/deepro/annot_cache/example/output" # TODO: set output dir path
glannot_image="/data6/deepro/annot_cache/glannot_latest.sif" # TODO: set glannot pulled image path

singularity exec --containall -H $cache_dir:/data -B $cache_dir:/data -B $input_dir:/input -B $output_dir:/output /data6/deepro/annot_cache/glannot_latest.sif vep --cache --dir_cache /data --vcf -i /input/sample.vcf.gz -o /output/sample.vcf  --plugin LoF,loftee_path:/plugins,gerp_bigwig:loftee/gerp_conservation_scores.homo_sapiens.GRCh38.bw,human_ancestor_fa:loftee/human_ancestor.fa.gz,conservation_file:loftee/loftee.sql --plugin CADD,cadd/whole_genome_SNVs.tsv.gz,cadd/InDels.tsv.gz --plugin dbNSFP,dbnsfp/dbNSFP4.3a_grch38.gz,LRT_score,GERP++_RS

echo `date` ending job on $HOSTNAME
