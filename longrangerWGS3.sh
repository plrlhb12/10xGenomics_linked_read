#!/bin/bash

SAMPLE=${1}
FASTQ=/data/CARD/tprojects/data/Psomagen/2004UAHS-0254/2004UAHS-02548_10X_RawData_Outs/fastq_path
REF=/data/CARD/tprojects/reference/10xGenomics/refdata-hsapiens-GRCh38/refdata-GRCh38-2.1.0

longranger wgs --id=$SAMPLE --reference=$REF --sex=m --fastqs=$FASTQ --sample=$SAMPLE --vcmode=gatk:/usr/local/apps/GATK/4.0.2.0/gatk-package-4.0.2.0-local.jar
