#!/bin/bash

SAMPLE=${1}
FASTQ=/data/CARD/tprojects/data/Psomagen/longranger/$SAMPLE
REF=/data/CARD/tprojects/reference/10xGenomics/refdata-hsapiens-GRCh38/refdata-GRCh38-2.1.0


# --sample= the value must match the prelix of the fastq file: NIST-reference_S1_L003_I1_001.fastq.gz
longranger wgs --id=NIST-reference --reference=$REF --sex=m --fastqs=$FASTQ --sample=NIST-reference --vcmode=gatk:/usr/local/apps/GATK/4.0.2.0/gatk-package-4.0.2.0-local.jar
