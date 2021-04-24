
# Prepare for longranger wgs pipeline: setup

## Examine the software needed for runing

Long Ranger uses GATK's HaplotypeCaller mode. for long ranger version 2.2, the compatable GATK version is 3.3-4.0, excluding 3.6
Changes to GATK occurring after version 4.0.3 have introduced an incompatibility with Long Ranger.

##############################################
## check it is availale in biowulf or not

'$module avail longranger'
------------ /usr/local/lmod/modulefiles --------------------

### default is /2.2.2
longranger/2.1.5    longranger/2.2.1    longranger/2.2.2 (D)


'$module avail gatk'
### The default is 3.8-1. We can choose GATK/4.0.2.0. Its abs path: /usr/local/lmod/modulefiles/GATK/4.0.2.0.lua
GATK/nightly-2016-05-26-g5dd804c    GATK/nightly-2017-11-15-1    GATK/3.4-0     GATK/3.6      GATK/3.8-1   (D)    GATK/4.0.8.1     GATK/4.1.0.0    GATK/4.1.4.1    GATK/4.1.8.0 GATK/nightly-2016-11-22-g69e703d    GATK/nightly-2017-12-04-1    GATK/3.4-46    GATK/3.7      GATK/4.0.0.0   GATK/4.0.11.0    GATK/4.1.2.0    GATK/4.1.6.0 GATK/nightly-2017-04-20-g2fc0960    GATK/3.3-0  GATK/3.5-0     GATK/3.8-0    GATK/4.0.2.0        GATK/4.0.12.0    GATK/4.1.3.0    GATK/4.1.7.0


'$module avail bcl2fastq'
### bcl2fastq 2.17 or higher is preferred
   bcl2fastq/2.17    bcl2fastq/2.19.0    bcl2fastq/2.20.0 (D)

'$module avail loupe'
### loup isn't in HPC
No modules found!

##############################################
## Download and **de-tar** the hg38 reference
### biowulf has reference data stored in /fdb/longranger/, however, only hg19 not hg38
'$ls /fdb/longranger/'

refdata-b37-1.2.0  refdata-b37-2.1.0.tar.gz  refdata-hg19-1.2.0  refdata-hg19-2.1.0  refdata-hg19-2.1.0.tar.gz  tiny-bcl-2.0.0.tar.gz  tiny-bcl-simple-2.1.0.csv

### 10x Genomics provides pre-built reference packages for use with the pipeline.
https://support.10xgenomics.com/genome-exome/software/pipelines/latest/advanced/references
### download reference genome data from 10x genomics: GRCh38 Reference - 2.1.0 (Sep 15, 2016)
'$curl -O https://cf.10xgenomics.com/supp/genome/refdata-GRCh38-2.1.0.tar.gz'
'$md5sum reference/10xGenomics/refdata-GRCh38-2.1.0.tar.gz'

###############################################
** remember helix does not allow to load modules, need to do it in biowulf 
** need to use interactive node to load module if want to explore it

## add Optional Reference Files togther with reference genome build, so generetae some folders
mkdir -p /data/CARD/tprojects/reference/10xGenomics/refdata-hsapiens-GRCh38/regions
mv /data/CARD/tprojects/reference/10xGenomics/refdata-GRCh38-2.1.0.tar.gz /data/CARD/tprojects/reference/10xGenomics/refdata-hsapiens-GRCh38/
tar -xzvf /data/CARD/tprojects/reference/10xGenomics/refdata-hsapiens-GRCh38/refdata-GRCh38-2.1.0.tar.gz
# 1. SV Calling Filter File
```
cd refdata-hsapiens-GRCh38
cd regions
wget https://cf.10xgenomics.com/supp/genome/GRCh38/sv_blacklist.bed
wget https://cf.10xgenomics.com/supp/genome/GRCh38/segdups.bedpe
```
# add Genes/Exons File for Loupe display purpose, optional
```
mkdir refdata-hsapiens-GRCh38/genes
cd genes
wget https://cf.10xgenomics.com/supp/genome/gene_annotations.gtf.gz
```

##################################################
# Now start to run 

Tips: correct the mistakens I have made
1. failure because conflict with the files left by last ran, delete the residual files, and rerun
2. make sure reference is untar
3. make sure the path of GATK4 is correct: change path of gakt:/usr/local/lmod/modulefiles/GATK/4.0.2.0.lua to gakt:/usr/local/apps/GATK/4.0.2.0/gatk-package-4.0.2.0-local.jar
5. add --sample=KOLF2-ARID2-A2 or other values for this option (dependent on the info in the name of fastq files)

##################################################

## 1. follwing thee biowolf example
Use the biowulf template. It uses sbatch, but not good for troubleshooting.
Advantages are the email notice.
https://hpc.nih.gov/apps/longranger.html

## The define of the longranger wgs pipeline Using GATK with Long Ranger
https://support.10xgenomics.com/genome-exome/software/pipelines/latest/using/gatk

## start interactive mode
```
sinteractive --cpus-per-task=16 --gres=lscratch:50
cd /lscratch/$SLURM_JOBID
module load longranger/2.2.2
module load GATK/4.0.2.0

sbatch --cpus-per-task=16 --mem=100g --time=24:00:00 longranger_sbatch.sh
sbatch --job-name=LongRanger --cpus-per-task=16 --mem=100g --time=12:00:00 longranger_sbatch.sh 

```
