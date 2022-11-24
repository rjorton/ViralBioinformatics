#!/bin/bash

#WARNING - this is a simple script to illustrate pipeline implementation
#Choosing an appropriate reference is critical (and somewhat manual step)
#The script will just report standard statistics into the log file - it will not determine if this is a good or bad sample/alignment
#For this script - the ivar consensus sequence generation will only works if the ref seq names are just PB2, PB1, PA etc - anything else it wont work
#The script does not work with gzipped fastq's - gunzip them first

#Example usage
#From within the ~/CourseData/AIV/U2008751/ directory:
#bash aiv_slovenia_pipeline.sh U2008751-n5_S4_L001_R1_001.fastq U2008751-n5_S4_L001_R2_001.fastq ~/CourseData/Refs/H4N6.fasta U2008751
#NB - do not enter the # symbol at the start - it is just used in this script to signify that line is a comment
readFile1=${1}
readFile2=${2}
refFile=${3}
name=${4}

#Create log file to store basic stats - delete it if already exists
rm ${name}_log.txt
touch ${name}_log.txt

#We use the echo command to output text messages to the log file - using >> appends to the file
echo "BASIC STATS FILE" >> ${name}_log.txt
echo "Read File 1 = ${readFile1}" >> ${name}_log.txt
echo "Read File 2 = ${readFile2}" >> ${name}_log.txt
echo "Ref File = ${refFile}" >> ${name}_log.txt
echo "Output name for SAM/BAM/Consensus etc = ${name}" >> ${name}_log.txt

echo "PRINSEQ STATS"  >> ${name}_log.txt
prinseq-lite.pl -stats_info -stats_len -stats_ns -fastq ${readFile1} -fastq2 ${readFile2} >> ${name}_log.txt

fastqc ${readFile1} ${readFile2}

#Run trim_galore on the raw reads
trim_galore -q 20 --length 50 --max_n 0 --paired ${readFile1} ${readFile2}

#Get the trim_galore file names
trimFile1="${readFile1%.f*q}_val_1.fq"
trimFile2="${readFile2%.f*q}_val_2.fq"

#bwa index the ref & then align the reads
bwa index ${refFile}
bwa mem -t 4 ${refFile} ${trimFile1} ${trimFile2} > ${name}.sam

#Convert the SAM to BAM & index
samtools sort -@4 ${name}.sam -o ${name}.bam
rm ${name}.sam
samtools index ${name}.bam

echo "Number of mapped reads in ${name}.bam" >> ${name}_log.txt
samtools view -c -F2308 ${name}.bam >> ${name}_log.txt

echo "Number of unmapped reads in ${name}.bam" >> ${name}_log.txt
samtools view -c -f4 ${name}.bam >> ${name}_log.txt

echo "samtools idxstats in ${name}.bam" >> ${name}_log.txt
samtools idxstats ${name}.bam  >> ${name}_log.txt

#run weeSAM - create a text output as well as html
weeSAM --bam ${name}.bam --html ${name}.html --out ${name}_weesam.txt --overwrite

# cut the segment name (1st column), breadth% (5th), and average coverage (8th) fields from the weeSAM output and append to log
echo "weeSAM coverage stats"
cut -f 1,5,8 ${name}_weesam.txt >> ${name}_log.txt

#Due to installation problems with ivar conflicting with other tools on the VM
#This script is going to need to activate the ivar conda env we created
#This is a little more complicated within a script - and not a fan of doing it this way
source ~/anaconda3/etc/profile.d/conda.sh
conda activate ivar

echo "ivar creating consensus for PB2" >> ${name}_log.txt
samtools mpileup -aa -A -d 0 -Q 0 -r PB2 ${name}.bam | ivar consensus -p ${name}-PB2 -t 0.4
echo "ivar creating consensus for PB1" >> ${name}_log.txt
samtools mpileup -aa -A -d 0 -Q 0 -r PB1 ${name}.bam | ivar consensus -p ${name}-PB1 -t 0.4
echo "ivar creating consensus for PA" >> ${name}_log.txt
samtools mpileup -aa -A -d 0 -Q 0 -r PA ${name}.bam | ivar consensus -p ${name}-PA -t 0.4
echo "ivar creating consensus for HA" >> ${name}_log.txt
samtools mpileup -aa -A -d 0 -Q 0 -r HA ${name}.bam | ivar consensus -p ${name}-HA -t 0.4
echo "ivar creating consensus for NP" >> ${name}_log.txt
samtools mpileup -aa -A -d 0 -Q 0 -r NP ${name}.bam | ivar consensus -p ${name}-NP -t 0.4
echo "ivar creating consensus for NA" >> ${name}_log.txt
samtools mpileup -aa -A -d 0 -Q 0 -r NA ${name}.bam | ivar consensus -p ${name}-NA -t 0.4
echo "ivar creating consensus for MP" >> ${name}_log.txt
samtools mpileup -aa -A -d 0 -Q 0 -r MP ${name}.bam | ivar consensus -p ${name}-MP -t 0.4
echo "ivar creating consensus for NS" >> ${name}_log.txt
samtools mpileup -aa -A -d 0 -Q 0 -r NS ${name}.bam | ivar consensus -p ${name}-NS -t 0.4

cat ${name}-*.fa > ${name}-genone.fasta

echo "Finished" >> ${name}_log.txt
