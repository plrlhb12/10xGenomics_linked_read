#!/bin/bash/

#SBATCH --job-name LongRanger
#SBATCH --mail-type BEGIN,END
#SBATCH -o /data/CARD/tprojects/data/Psomagen/longranger.out
#SBATCH -e /data/CARD/tprojects/data/Psomagen/longranger.err

FASTQ=/data/CARD/tprojects/data/Jax/10X_Genomics_WGS
REF=/data/CARD/tprojects/reference/10xGenomics/refdata-hsapiens-GRCh38/refdata-GRCh38-2.1.0

longranger wgs --id=KOLF2-C1-JAX-out --reference=$REF --sex=m --fastqs=$FASTQ/KOLF2-C1-JAX --sample=KOLF2-C1-JAX --vcmode=gatk:/usr/local/apps/GATK/4.0.2.0/gatk-package-4.0.2.0-local.jar
