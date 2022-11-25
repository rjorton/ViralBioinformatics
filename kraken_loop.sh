#!/bin/bash

#bash kraken_loop.sh /data/iaea

for fq in ${1}/*_R1_001.fastq.gz
do
        echo "R1 = ${fq}"

        fq2="${fq%_R1_001.fastq.gz}_R2_001.fastq.gz"
        echo "R2 = ${fq2}"
        
        sample="$(basename -- ${fq%_R1_001.fastq.gz})"
        echo "Sample = ${sample}"
        
	kraken2 -db ~/CourseData/Kraken/Viral --threads 4 --report ${sample}_kraken_report.txt --output ${sample}_kraken_output.txt --paired ${fq} ${fq2}
	ktImportTaxonomy -q 2 -t 3 -s 4 ${sample}_kraken_output.txt -o ${sample}_krona.html
done
