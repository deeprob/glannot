# Annotation pipeline - Girirajan Lab
This repository holds the source code and instructions to run Girirajan Lab's project VCF annotation pipeline. Current pipeline uses VEP (Variant Effect Predictor) along with CADD, dbSNFP and Loftee to annotate VCF files. To run the pipeline please refer to the README files present within the folder CPU or SLURM depending on your platform. 

The description of the files and folders present in this repository is as follows:

- CPU: This folder holds instructions to run the pipeline on local machine
- SLURM: This folder holds instructions to run the pipeline on SLURM cluster
- DOCKER: This folder holds the dockerfile used to create a docker image of the pipeline

# Current pipeline tools and plugins version numbers
VEP: release 109

Loftee: v1.0.4 grch38 branch

CADD: v1.6 for SNVs and v1.5 for InDels

dbNSFP: v4.3a


# Resources
1. http://useast.ensembl.org/info/docs/tools/vep/script/vep_download.html#docker
2. https://github.com/Iaguilaror/nf-VEPextended/blob/master/test/data/
3. https://docs.docker.com/build/building/multi-stage/
4. https://carpentries-incubator.github.io/singularity-introduction/05-singularity-docker/index.html
5. https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry
6. https://docs.github.com/en/packages/learn-github-packages/connecting-a-repository-to-a-package
7. https://codefresh.io/docs/docs/integrations/docker-registries/github-container-registry/
