#!/bin/bash

#REMEMBER TO CALL DOCKER FOR GATK!!!!!!

for value in 11R-1075341 12R-1074157 6R-1073365 7R-1071737 8R-1075225
do
	echo "$value"
	cd $value
	cd alignment

	# Filter SNPs & INDELS

	gatk VariantFiltration -R ../../hg38_fa/hg38.fa -V ${value}_raw_snps.vcf -filter "QD < 2.0" --filter-name "QD2" -filter "QUAL < 30.0" --filter-name "QUAL30" -filter "SOR > 3.0" --filter-name "SOR3" -filter "FS > 60.0" --filter-name "FS60" -filter "MQ < 40.0" --filter-name "MQ40" -filter "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" -filter "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" -O ${value}_raw_snps-filtered.vcf 
	gatk VariantFiltration -R ../../hg38_fa/hg38.fa -V ${value}_raw_indels.vcf -filter "QD < 2.0" --filter-name "QD2" -filter "QUAL < 30.0" --filter-name "QUAL30" -filter "FS > 200.0" --filter-name "FS200" -filter "ReadPosRankSum < -20.0" --filter-name "ReadPosRankSum-20" -O ${value}_raw_indels-filtered.vcf

	echo "finished $value"
	echo "\n\n"   
	cd ..
	cd ..
done
