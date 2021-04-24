
# Jax 10x genmoics data 

Jax datasets have different dir structure as posmagen becuase Jax didn't copy the relative Project folder and the associated stats and reports. In addition, the names of fastq files are also a little bit different.

1. For the example of KOLF2-C1, the sample names have 4:GT17-001-B-1, GT17-001-B-2, GT17-001-B-3,GT17-001-B-4, I need to put them into
--sample=GT17-001-B-1,GT17-001-B-2,GT17-001-B-3,GT17-001-B-4

gs://singlecellindi/WGS/Jax/10xGenomicsWGS/KOLF2-C1
2f31666562e476d4f9d0f2fbb486dba1  GT17-001-B-1_S1_L001_I1_001.fastq.gz
175b72162c146f36efe93c29ad03b242  GT17-001-B-1_S1_L001_R1_001.fastq.gz
a75fec0f89b6699e9c7b86d5d658ec04  GT17-001-B-1_S1_L001_R2_001.fastq.gz
6fa579e1bcfab210b0c09454974b3bd8  GT17-001-B-2_S2_L001_I1_001.fastq.gz
5dc536f96849bd72cfd66820c0e0535f  GT17-001-B-2_S2_L001_R1_001.fastq.gz
06954489c276261b95e9b527bc82ec27  GT17-001-B-2_S2_L001_R2_001.fastq.gz
01abb843840cc41af9d132ff2e50cf94  GT17-001-B-3_S3_L001_I1_001.fastq.gz
20c9c56260d4084fe938eec753f5f718  GT17-001-B-3_S3_L001_R1_001.fastq.gz
714716d313e41aa112af0f5448763128  GT17-001-B-3_S3_L001_R2_001.fastq.gz
21785d26a1e1838ee129aa7047f78cc8  GT17-001-B-4_S4_L001_I1_001.fastq.gz
13883a16ec3cf96e5d4188abc11841ad  GT17-001-B-4_S4_L001_R1_001.fastq.gz
2a2f4ad08a1fb0d26ec55be3a0aefc27  GT17-001-B-4_S4_L001_R2_001.fastq.gz

2. For KUCG-C1, it has only one sample name: KUCGC1WGS_GT19-067_SI-GA-H1
gs://singlecellindi/WGS/Jax/10xGenomicsWGS/KUCG-C1
-rw-rw----+ 1 pengl7 CARD  27G Aug 21 11:18 KUCGC1WGS_GT19-067_SI-GA-H1_S5_L001_R1_001.fastq.gz
-rw-rw----+ 1 pengl7 CARD  27G Aug 21 11:18 KUCGC1WGS_GT19-067_SI-GA-H1_S5_L001_R2_001.fastq.gz
-rw-rw----+ 1 pengl7 CARD 1.9G Aug 21 11:14 KUCGC1WGS_GT19-067_SI-GA-H1_S5_L001_I1_001.fastq.gz

########################

# Fisrt failed case:
## move jax 10xgenomics data to posmagen's folder of 2004UAHS-0254/KOLF2-C1-JAX
data/Jax/10X_Genomics_WGS/KOLF2-C1-JAX /data/CARD/tprojects/data/Psomagen/2004UAHS-0254/2004UAHS-02548_10X_RawData_Outs/fastq_path/2004UAHS-0254
data/Jax/10X_Genomics_WGS/KUCG-C1-JAX /data/CARD/tprojects/data/Psomagen/2004UAHS-0254/2004UAHS-02548_10X_RawData_Outs/fastq_path/2004UAHS-0254

swarm -f longranger3.swarm -g 120 -t 56 --time 72:00:00 --module longranger/2.2.2.lua,GATK/4.0.2.0.lua

## error1: the sample name of KOLF2-C1-JAX and KUCG-C1-JAX doesn't contained in its fastq file names, change the name

```
cd /data/CARD/tprojects/data/Psomagen/2004UAHS-0254/2004UAHS-02548_10X_RawData_Outs/fastq_path/2004UAHS-0254/KOLF2-C1-JAX

for file in *gz
do
file_name=$file
echo $file_name
sed -i -e s'/KOLF2-C1-JAX_//'g $file_name
echo $file_name
done

mv $file_name KOLF2-C1-JAX_$file_name

gsutil -m cp -r gs://transfer_27may/Jax/'10X Genomics WGS'/KOLF2-C1/* ./

# change the file name of KUCG-C1 sample

mv KUCGC1WGS_GT19-067_SI-GA-H1_S5_L001_R2_001.fastq.gz KUCG-C1-Jax_GT19-067_SI-GA-H1_S5_L001_R2_001.fastq.gz
mv KUCGC1WGS_GT19-067_SI-GA-H1_S5_L001_R1_001.fastq.gz KUCG-C1-Jax_GT19-067_SI-GA-H1_S5_L001_R1_001.fastq.gz
mv KUCGC1WGS_GT19-067_SI-GA-H1_S5_L001_I1_001.fastq.gz KUCG-C1-Jax_GT19-067_SI-GA-H1_S5_L001_I1_001.fastq.gz
```
## error2: still have the error message because their didn't bring their stats and Reports files together

Invalid path/prefix combination: /gpfs/gsfs9/users/CARD/tprojects/data/Psomagen/2004UAHS-0254/2004UAHS-02548_10X_RawData_Outs/fastq_path/2004UAHS-0254, ['KOLF2-C1-JAX']
Samples not detected among demultiplexed FASTQs: KOLF2-C1-JAX
Invalid path/prefix combination: /gpfs/gsfs9/users/CARD/tprojects/data/Psomagen/2004UAHS-0254/2004UAHS-02548_10X_RawData_Outs/fastq_path/2004UAHS-0254, ['KUCG-C1-JAX']
Samples not detected among demultiplexed FASTQs: KUCG-C1-JAX


################################

61621776

## move back Jax to its own folder, add --sample=... to longrangerWGS4.sh
## failed because conflict with the files left by last ran, delete the residual files, and rerun
## using longrangerWGS4.sh and longrange4.swarm

```
mv /data/CARD/tprojects/data/Psomagen/2004UAHS-0254/2004UAHS-02548_10X_RawData_Outs/fastq_path/2004UAHS-0254/*JAX /data/CARD/tprojects/data/Jax

swarm -f longranger4.swarm -g 240 -t 76 --time 48:00:00 --module longranger/2.2.2.lua,GATK/4.0.2.0.lua

```