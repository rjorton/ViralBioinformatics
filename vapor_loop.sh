#!/bin/bash

#bash vapor_loop.sh /data/iaea

for fq in ${1}/*_R1_001.fastq.gz
do
        echo "R1 = ${fq}"

        fq2="${fq%_R1_001.fastq.gz}_R2_001.fastq.gz"
        echo "R2 = ${fq2}"
        
        sample="$(basename -- ${fq%_R1_001.fastq.gz})"
        echo "Sample = ${sample}"
        
        ~/programs/vapor/vapor.py --return_best_n 100 -fq ${fq} ${fq2} -fa ~/CourseData/Refs/HA_AIV_Europe.fasta > ${sample}_vapor_results_HA.txt
        ~/programs/vapor/vapor.py --return_best_n 100 -fq ${fq} ${fq2} -fa ~/CourseData/Refs/NA_AIV_Europe.fasta > ${sample}_vapor_results_NA.txt
done
