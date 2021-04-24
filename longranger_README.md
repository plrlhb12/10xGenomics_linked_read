# Run longer wgs using swarm, because the -e and -o files provide useful info for error check
#####################################
# Tricks in the paths and variables
## pitfalls of --id
- The --id is tricky. It is the name of output folder. If there is already a folder with the same name in the directory where cd... as defined by long ranger.swarm, there will be error.
- The --id should be different for each analytic command line, otherwise the output will be overwritten
- It is better to use id=${SAMPLE}_out

## pitfalls of fastq path
### One of the two kinds of path of fastq
- If all the fastq files are in structure of ....fastq_path/PROJECT/SAMPLE/sample-name_s1_.....fastq and together with the associated stats and reports in the PROJECT folder, then the fastq path end in.../fastq_path, instead of ending at.../SAMPLE

### make sure the value of SAMPLE is the the prefix of fastq file
```
SAMPLE=${1}
FASTQ=/data/CARD/tprojects/data/Psomagen/2004UAHS-0254/2004UAHS-02548_10X_RawData_Outs/fastq_path
```
### The other of the two kinds of path of fastq
- If the fastq files are just in a separate folder like .......SAMPLE/sample-name_S1....without stats and reports in its parent folder above SAMPLE folder

```
SAMPLE=${1}
FASTQ=/data/CARD/tprojects/data/Psomagen/2004UAHS-0254/2004UAHS-02548_10X_RawData_Outs/SMAPLE
```
## previous mistakes
1. make big mistakes by putting multiple command lines in the .sh file, they should be mulitple simillar tasks in the .swarm file
2. remember to delete the folder run by last time if it failed
3. remember to change the id= output folder name, so set different value for each task, otherwise the output will be overwrited
4. id's value should be not the same as a folder name in the current directory where .sh file reside in, otherwise the error will be as RuntimeError: /data/CARD/tprojects/data/Psomagen/longranger/NIST-reference is not a pipestance directory
5. solution: either set id=${SAMPLE}_out


### I already made some changes in the longer_tempates.sh in the naming of --id, it would avoid all the pitfalls as above. 

Just don't mix these data with different structure together, i.e., don't copy the data from a stand alone SAMPLE/ folder into the above fastq_path/PROJECT/SAMPLE, it would not work because the stats and reports in the PROJECT folder don't have the info from new copied samples.

## Options in defining --sample

- If want to analyse all fastq from all sample as one: --fastqs=.../fastaq_path (skip --sample)
- If want to analyse for each sample under PROJECT folder for each: --fastqs=.../fastaq_path --sample=$SAMPLE
- If want to analyse for a sample using only some lanes: --fastqs=.../fastaq_path --sample=$SAMPLE --lane=l1

######################################
# CASES: the details are in the longranger_templates.sh, rembermber to use the corresponidng swarm file

## CASE1:
1. working directory ans warm files are in /data/CARD/tprojects/
2. The fastq path is the format: fastq_path/PROJECT/SAMPLE
3. longranger.sh files are in /data/CARD/tprojects/data/Psomagen/longranger

```
/data/CARD/tprojects/data/Psomagen/2004UAHS-0254/2004UAHS-02548_10X_RawData_Outs/fastq_path/2004UAHS-0254/KOLF2-ARID2-A2

swarm -f longranger4.swarm -g 240 -t 72 --time 48:00:00 --module longranger/2.2.2.lua,GATK/4.0.2.0.lua -devel
61792784

swarm -f longranger3.swarm -g 240 -t 72 --partition=norm,ccr --time 72:00:00 --module longranger/2.2.2.lua,GATK/4.0.2.0.lua
61792642
```

## CASE3:
`swarm -f longranger-NIST.swarm -g 240 -t 72 --time 48:00:00 --module longranger/2.2.2.lua,GATK/4.0.2.0.lua`

########################################
## run and check 
It takes about 36 hours to be finished
```
sinteractive
module list
longranger wgs --help
freen
squeue -u pengl7
sjobs -u pengl7
jobload -u pengl7
sacct
sacct --state f
exit$ 
scancel  232323	
```
https://hpc.nih.gov/dashboard/
