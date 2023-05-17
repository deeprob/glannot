# Running the annotation pipeline on SLURM

## Run data preparation pipeline using the provided slurm script

1. Edit sbatch variables and environmental variables marked as "TODO" in *prepare.sh*

2. Run the script *prepare.sh*
    ```bash
    $ sbatch prepare.sh
    ```

**Note: The script assumes that the following tools are previously installed and on path: ```unzip, wget, gzip, tabix, git```.**

## Run annotation pipeline using singularity

1. Pull image from GHCR
    ```bash
    $ singularity pull docker://ghcr.io/deeprob/glannot:latest
    ```
    Note the path where the image is downloaded

2. Edit sbatch variables and environmental variables marked as "TODO" in *download_vep.sh* and *run_pipeline.sh*

3. Download cache files required by VEP
    ```bash
    $ sbatch download_vep.sh
    ```

4. Run pipeline with plugins
    ```bash
    $ sbatch run_pipeline.sh
    ```

**Note: The scripts assume that singularity is installed and on path.**

# Resources

1. https://www.ensembl.info/2021/05/24/cool-stuff-the-vep-can-do-singularity/
