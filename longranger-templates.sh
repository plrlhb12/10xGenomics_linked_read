#!/bin/bash


# CASEE 1: SAMPLE input is sample name, e.g., KOLF2-ARID2-A2
# make sure the value of $SAMPLE is the the prefix of fastq file
SAMPLE=${1}
FASTQ=/data/CARD/tprojects/data/Psomagen/2004UAHS-0254/2004UAHS-02548_10X_RawData_Outs/fastq_path
REF=/data/CARD/tprojects/reference/10xGenomics/refdata-hsapiens-GRCh38/refdata-GRCh38-2.1.0

longranger wgs --id=${SAMPLE}_genotype --reference=$REF --sex=m --fastqs=$FASTQ --sample=$SAMPLE --vcmode=gatk:/usr/local/apps/GATK/4.0.2.0/gatk-package-4.0.2.0-local.jar




# CASE 2: 
# don't have stats and reports in the pareental folder of the folder of $Mysample, single read group
# make sure the value of $SAMPLE is the the prefix of fastq file: NIST-reference
# NIST-reference_S1_L003_I1_001.fastq.gz
SAMPLE=${1}
FASTQ=/data/CARD/tprojects/data/Psomagen/longranger/$SAMPLE
REF=/data/CARD/tprojects/reference/10xGenomics/refdata-hsapiens-GRCh38/refdata-GRCh38-2.1.0

longranger wgs --id=${SAMPLE}_genotype --reference=$REF --sex=m --fastqs=$FASTQ --sample=$SAMPLE --vcmode=gatk:/usr/local/apps/GATK/4.0.2.0/gatk-package-4.0.2.0-local.jar

# CASE 3:
# don't have stats and reports in the pareental folder of the folder of $Mysample
# one fastq folder has mulitiple read groups (the example of Jax 10X Genomics KOLF2-C1)

# SAMPLE input $SAMPLE is KOLF2-C1, not the part of the fastq file anymore

# need to define the --sample=GT17-001-B-1,GT17-001-B-2,GT17-001-B-3,GT17-001-B-4
# GT17-001-B-1_S1_L001_R1_001.fastq.gz
# GT17-001-B-2_S2_L001_R1_001.fastq.gz
# GT17-001-B-3_S3_L001_R1_001.fastq.gz
# GT17-001-B-4_S4_L001_R1_001.fastq.gz

SAMPLE=${1}
FASTQ=/data/CARD/tprojects/data/Psomagen/longranger/$SAMPLE
REF=/data/CARD/tprojects/reference/10xGenomics/refdata-hsapiens-GRCh38/refdata-GRCh38-2.1.0

longranger wgs --id=${SAMPLE}_genotype --reference=$REF --sex=m --fastqs=$FASTQ --sample=GT17-001-B-1,GT17-001-B-2,GT17-001-B-3,GT17-001-B-4 --vcmode=gatk:/usr/local/apps/GATK/4.0.2.0/gatk-package-4.0.2.0-local.jar

