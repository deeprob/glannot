#!/bin/bash

# Sets up files and plugins required to run Girirajan Lab project VCF file annotation pipeline
# Assumes the following are in PATH
# unzip, wget, gzip, tabix, git

# set cache dir: where all files and plugins will be stored
cache_dir="/path/to/cache_dir" # edit this path

cd $cache_dir

# download cadd files
mkdir cadd
cd cadd
echo "Downloading CADD files ..."
wget -c https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh38/whole_genome_SNVs.tsv.gz
wget -c https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh38/whole_genome_SNVs.tsv.gz.tbi
wget -c https://krishna.gs.washington.edu/download/CADD/v1.5/GRCh38/InDels.tsv.gz
wget -c https://krishna.gs.washington.edu/download/CADD/v1.5/GRCh38/InDels.tsv.gz.tbi
echo "CADD files downloaded."
cd ../


# download and parse dbNSFP files
mkdir dbnsfp
cd dbnsfp
echo "Downloading dbNSFP files ..."
wget -c ftp://dbnsfp:dbnsfp@dbnsfp.softgenetics.com/dbNSFP4.3a.zip
unzip dbNSFP4.3a.zip
zcat dbNSFP4.3a_variant.chr1.gz | head -n1 > h
zgrep -h -v ^#chr dbNSFP4.3a_variant.chr* | sort -k1,1 -k2,2n - | cat h - | bgzip -c > dbNSFP4.3a_grch38.gz
tabix -s 1 -b 2 -e 2 dbNSFP4.3a_grch38.gz
echo "dbNSFP files downloaded."
cd ../

# download loftee files
mkdir loftee
cd loftee
echo "Downloading Loftee files ..."
wget -c https://personal.broadinstitute.org/konradk/loftee_data/GRCh38/gerp_conservation_scores.homo_sapiens.GRCh38.bw
wget -c https://personal.broadinstitute.org/konradk/loftee_data/GRCh38/human_ancestor.fa.gz
wget -c https://personal.broadinstitute.org/konradk/loftee_data/GRCh38/human_ancestor.fa.gz.fai
wget -c https://personal.broadinstitute.org/konradk/loftee_data/GRCh38/human_ancestor.fa.gz.gzi
wget -c https://personal.broadinstitute.org/konradk/loftee_data/GRCh38/loftee.sql.gz
gzip -d loftee.sql.gz
rm loftee.sql.gz
echo "Loftee files downloaded."
cd ../
