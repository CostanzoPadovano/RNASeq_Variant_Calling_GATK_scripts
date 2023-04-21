#!/bin/bash

#REMEMBER TO CALL DOCKER FOR GATK!!!!!!

for value in 11R-1075341 12R-1074157 6R-1073365 7R-1071737 8R-1075225
do
  echo "$value"
  cd $value
  cd alignment

  gatk HaplotypeCaller -I ${value}_sorted_dedup_bqsr_reads.bam -R ../../hg38_fa/hg38.fa -O ${value}_raw_variants.vcf --native-pair-hmm-threads 22 -bamout ${value}_after_haplotype_bamout.bam

  # extract SNPs & INDELS

  gatk SelectVariants -R ../../hg38_fa/hg38.fa -V ${value}_raw_variants.vcf --select-type SNP -O ${value}_raw_snps.vcf
  gatk SelectVariants -R ../../hg38_fa/hg38.fa -V ${value}_raw_variants.vcf --select-type INDEL -O ${value}_raw_indels.vcf

  echo "finished $value"
  echo "\n\n"   
  cd ..
  cd ..
done