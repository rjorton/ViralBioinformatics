# Regional Training Course on Next Generation Sequencing (NGS) using Illumina Platform
## Maribor, Slovenia 2022

[https://elixir.mf.uni-lj.si/enrol/index.php?id=99](https://elixir.mf.uni-lj.si/enrol/index.php?id=99)

TinyURL for this GitHub page: [https://tinyurl.com/vbio2022](https://tinyurl.com/vbio2022)

## Command line bioinformatics script

Bash script of all the different steps we learnt pieced together. Example usage:

Move into the sample folder:

```
cd ~/CourseData/AIV/U2008751
```

Download the script:

```
wget https://raw.githubusercontent.com/rjorton/ViralBioinformatics/main/aiv_slovenia_pipeline.sh
```

Run the script

```
bash aiv_slovenia_pipeline.sh U2008751-n5_S4_L001_R1_001.fastq U2008751-n5_S4_L001_R2_001.fastq ~/CourseData/Refs/H4N6.fasta U2008751
```

## Your sequence data

The FASTQ reads of the samples you actually Illumina sequenced are in /data/iaea on the VMs:

```
1260-7_S7_R1_001.fastq.gz        
1260-7_S7_R2_001.fastq.gz   
1662-5_S5_R1_001.fastq.gz       
1662-5_S5_R2_001.fastq.gz  
2213-6_S6_R1_001.fastq.gz        
2213-6_S6_R2_001.fastq.gz   
2498-8_S8_R1_001.fastq.gz          
2498-8_S8_R2_001.fastq.gz     
2987-2_S2_R1_001.fastq.gz     
2987-2_S2_R2_001.fastq.gz      
3229-11_S11_R1_001.fastq.gz      
3229-11_S11_R2_001.fastq.gz      
Undetermined_S0_R2_001.fastq.gz
Undetermined_S0_R1_001.fastq.gz
2606-1_S1_R1_001.fastq.gz      
2606-1_S1_R2_001.fastq.gz  
1306-4_S4_R1_001.fastq.gz 
1306-4_S4_R2_001.fastq.gz 
1734-9_S9_R1_001.fastq.gz        
1734-9_S9_R2_001.fastq.gz   
2214-3_S3_R1_001.fastq.gz      
2214-3_S3_R2_001.fastq.gz    
2988-10_S10_R1_001.fastq.gz        
2988-10_S10_R2_001.fastq.gz    
5177-12_S12_R1_001.fastq.gz    
5177-12_S12_R2_001.fastq.gz 
```

## Vapor results

On the VM iaea13 I did a quick vapor loop of each sample against the European Avian IAV HA and NA seqs:

```
bash vapor_loop.sh /data/iaea
```

## Kraken results

On the VM iaea15 I did a quick kraken loop of each sample against the mini krakenDB:

```
bash kraken_loop.sh /data/iaea
```

