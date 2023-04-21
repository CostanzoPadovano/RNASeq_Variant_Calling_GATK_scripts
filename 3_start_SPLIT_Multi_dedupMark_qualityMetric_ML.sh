#!/bin/bash



for value in 1R-1068217
do
	echo "$value"
	cd $value
	cd alignment


	# 1. SplitNCigarReads

	gatk SplitNCigarReads -R ../../hg38_fa/hg38.fa -I ${value}_sample_dedup_reads.bam -O ${value}_sample_dedup_reads-splitreads.bam

	echo "STEP 4: Base quality recalibration"

	# 2. build the model
	gatk BaseRecalibrator -I ${value}_sample_dedup_reads-splitreads.bam -R ../../hg38_fa/hg38.fa --known-sites ../../GATK/DATABASE/resources_broad_hg38_v0_Homo_sapiens_assembly38.dbsnp138.vcf -O recal_data.table


	# 3. Apply the model to adjust the base quality scores
	gatk ApplyBQSR -I ${value}_sample_dedup_reads-splitreads.bam -R ../../hg38_fa/hg38.fa --bqsr-recal-file recal_data.table -O ${value}_sorted_dedup_bqsr_reads.bam 

	echo "finished ${value}"
	cd ..
	cd ..
done
