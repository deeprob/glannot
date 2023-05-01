# Running the annotation pipeline on CPU

## Run data preparation pipeline using the provided shell script

1. Edit the *cache_dir* variable in *prepare.sh* to your directory of choice. This directory will host all files required to annotate the VCF. __Make sure it has sufficient space__. 

2. Run the script *prepare.sh*
    ```bash
    $ bash prepare.sh
    ```

**Note: The script assumes that the following tools are previously installed/on path: ```unzip, wget, gzip, tabix, git```.**


## Run annotation pipeline using docker 

1. Pull the docker image from docker hub
    ```bash
    $ docker pull ghcr.io/deeprob/glannot:latest
    ```

2. Set the correct directories
    ```bash
    $ cache_dir="/path/to/cache_dir" # directory where previously downloaded files are stored
    $ input_dir="/path/to/input/vcf" # directory where the vcf file to be annotated is stored
    $ output_dir="/path/to/output/vcf" # directory where the annotated vcf file will be stored
    ```

3. Download cache files required by VEP
    ```bash
    $ docker run -t -i -v $cache_dir:/data ghcr.io/deeprob/glannot:latest INSTALL.pl -a cf -s homo_sapiens -y GRCh38
    ```

4. Run pipeline with plugins
    ```bash
    $ docker run -v $cache_dir:/data -v $input_dir:/input -v $output_dir:/output ghcr.io/deeprob/glannot:latest vep --cache --vcf -i /input/chr22.vcf.gz -o /output/chr22.vcf  --plugin LoF,loftee_path:/plugins,gerp_bigwig:loftee/gerp_conservation_scores.homo_sapiens.GRCh38.bw,human_ancestor_fa:loftee/human_ancestor.fa.gz,conservation_file:loftee/loftee.sql --plugin CADD,cadd/whole_genome_SNVs.tsv.gz,cadd/InDels.tsv.gz --plugin dbNSFP,dbnsfp/dbNSFP4.3a_grch38.gz,LRT_score,GERP++_RS
    ```
