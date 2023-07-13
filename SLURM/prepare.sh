#!/bin/bash
#SBATCH --account=girirajan # TODO: set account name
#SBATCH --partition=girirajan # TODO: set slurm partition
#SBATCH --job-name=glannot_prep 
#SBATCH --ntasks=3
#SBATCH --cpus-per-task=4
#SBATCH --time=400:0:0
#SBATCH --mem-per-cpu=10G
#SBATCH --chdir /data6/deepro/annot_cache # TODO: set dir to cache dir
#SBATCH -o /data6/deepro/annot_cache/slurm/logs/out_prepare.log # TODO: set slurm output file
#SBATCH -e /data6/deepro/annot_cache/slurm/logs/err_prepare.log # TODO: set slurm input file
#SBATCH --exclude=durga,ramona,laila


echo `date` starting job on $HOSTNAME

export HOME="/data6/deepro/annot_cache" # TODO: set dir to cache dir
export TMPDIR="/data6/deepro/annot_cache" # TODO: set dir to cache dir

# Sets up files and plugins required to run Girirajan Lab project VCF file annotation pipeline
# Assumes the following are in PATH
# unzip, wget, gzip, tabix, git

# download cadd files
cadd_cmd=(
    "echo $PWD;"
    "mkdir cadd;" 
    "cd cadd;"
    "echo 'Downloading CADD files ...';" 
    "wget -c https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh38/whole_genome_SNVs.tsv.gz;"
    "wget -c https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh38/whole_genome_SNVs.tsv.gz.tbi;"
    "wget -c https://krishna.gs.washington.edu/download/CADD/v1.5/GRCh38/InDels.tsv.gz;"
    "wget -c https://krishna.gs.washington.edu/download/CADD/v1.5/GRCh38/InDels.tsv.gz.tbi;" 
    "echo 'CADD files downloaded.'"
)

# download and parse dbNSFP files
dbnsfp_cmd=(
    "echo $PWD;"
    "mkdir dbnsfp;"
    "cd dbnsfp;"
    "echo 'Downloading dbNSFP files ...';"
    "version=4.4a;"
    "wget -c ftp://dbnsfp:dbnsfp@dbnsfp.softgenetics.com/dbNSFP\${version}.zip;"
    "unzip dbNSFP\${version}.zip;"
    "zcat dbNSFP\${version}_variant.chr1.gz | head -n1 > h;"
    "zgrep -h -v ^#chr dbNSFP\${version}_variant.chr* | sort -k1,1 -k2,2n - | cat h - | bgzip -c > dbNSFP\${version}_grch38.gz;"
    "tabix -s 1 -b 2 -e 2 dbNSFP\${version}_grch38.gz;"
    "echo 'dbNSFP files downloaded.';"
)

# download loftee files
loftee_cmd=(
    "echo $PWD;"
    "mkdir loftee;"
    "cd loftee;"
    "echo 'Downloading Loftee files ...';"
    "wget -c https://personal.broadinstitute.org/konradk/loftee_data/GRCh38/gerp_conservation_scores.homo_sapiens.GRCh38.bw;"
    "wget -c https://personal.broadinstitute.org/konradk/loftee_data/GRCh38/human_ancestor.fa.gz;"
    "wget -c https://personal.broadinstitute.org/konradk/loftee_data/GRCh38/human_ancestor.fa.gz.fai;"
    "wget -c https://personal.broadinstitute.org/konradk/loftee_data/GRCh38/human_ancestor.fa.gz.gzi;"
    "wget -c https://personal.broadinstitute.org/konradk/loftee_data/GRCh38/loftee.sql.gz;"
    "gzip -d loftee.sql.gz;"
    "rm loftee.sql.gz;"
    "echo 'Loftee files downloaded.';"
)


srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK bash -c "${cadd_cmd[*]}" &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK bash -c "${dbnsfp_cmd[*]}" &
srun --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK bash -c "${loftee_cmd[*]}" &
wait

echo `date` ending job on $HOSTNAME
