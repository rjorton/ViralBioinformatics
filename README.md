# Viral Bioinformatics Course - Maribor, Slovenia 2022

TinyURL: [https://tinyurl.com/vbio2022](https://tinyurl.com/vbio2022)

Bash script of all the different steps we weren't pieced together

```
bash aiv_slovenia_pipeline.sh U2008751-n5_S4_L001_R1_001.fastq U2008751-n5_S4_L001_R2_001.fastq ~/CourseData/Refs/H4N6.fasta U2008751
```

To get the script (or just copy and paste the text somewhere!)

```
wget https://raw.githubusercontent.com/rjorton/ViralBioinformatics/main/aiv_slovenia_pipeline.sh
```

The FASTQ reads of the samples you actually sequenced are in /data/iaea on the VMs:

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

On iaea13 I did a quick vapor loop of each sample against the European Avian IAV seqs

```
bash vapor_loop.sh /data/iaea
```
