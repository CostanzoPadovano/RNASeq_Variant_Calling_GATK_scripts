#!/bin/bash

#REMEMBER TO CALL DOCKER FOR GATK!!!!!!

for value in 1R-1068217
do
	echo "$value"
	cd $value
	cd alignment

	# Building Database from 
	#date
	java -jar ../../Script_run/snpEff/snpEff.jar -v hg38 -s ${value}_snp_snpEff_summary.html ${value}_raw_snps.vcf > ${value}_raw_snps_filtered-Annotated.vcf
	
	#date
	#java -jar ../../Script_run/snpEff/snpEff.jar -v hg38 -s ${value}_indel_snpEff_summary.html ${value}_raw_indels.vcf > ${value}_raw_indels-filtered-Annotated.vcf 

	echo "finished $value"
	echo " "   
	echo " "
	echo " "
	echo " "
	
	cd ..
	cd ..
done
