#!/bin/bash

FASTQ=/data/CARD/tprojects/data/Jax/10X_Genomics_WGS
REF=/data/CARD/tprojects/reference/10xGenomics/refdata-hsapiens-GRCh38/refdata-GRCh38-2.1.0


# this is for Jax 10xGenomics data which doesn't work when put inside Psomagen folder
longranger wgs --id=KOLF2-C1-JAX --reference=$REF --sex=m --fastqs=$FASTQ/KOLF2-C1-JAX --sample=KOLF2-C1-JAX_GT17-001-B-1,KOLF2-C1-JAX_GT17-001-B-2,KOLF2-C1-JAX_GT17-001-B-3,KOLF2-C1-JAX_GT17-001-B-4 --vcmode=gatk:/usr/local/apps/GATK/4.0.2.0/gatk-package-4.0.2.0-local.jar

