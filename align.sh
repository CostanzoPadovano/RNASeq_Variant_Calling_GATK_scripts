#!/bin/bash
#I got part of this code from kpatel427 (github name) and I adapted it for RNA-seq variant calling following this guide: https://gatk.broadinstitute.org/hc/en-us/articles/360035531192-RNAseq-short-variant-discovery-SNPs-Indels-

###################################################### VARIANT CALLING STEPS ####################################################################

#ToMODIFY
# directories 
ref="./hg38_fa/hg38.fa"
known_sites="hg38/Homo_sapiens_assembly38.dbsnp138.vcf"
#aligned_reads="fastq_file/aligned_reads"

name_file=$(echo $file1 | cut -d"." -f 1)
num_LANE=$(echo $file1 | cut -d'L' -f 2 | cut -d'_' -f 1) #non modificare!

results="/results"
data="/data"
Threads_choosed=22
picard="../Script_run/picard.jar"

# -------------------
# STEP 1: QC - Run fastqc 
# -------------------

##echo "STEP 1: QC - Run fastqc"

##fastqc ${reads}/SRR062634_1.filt.fastq.gz -o ${reads}/
##fastqc ${reads}/SRR062634_2.filt.fastq.gz -o ${reads}/

# No trimming required, quality looks okay.

# --------------------------------------
# STEP 2 FOR RNA-Seq: Map to reference using STAR
# --------------------------------------

#BUILD A GENOME INDEX USING STAR
##echo "BUILD A GENOME INDEX USING STAR"
##date
##STAR --runMode genomeGenerate --runThreadN 4 --genomeDir ./ --genomeFastaFiles $ref

#Align RNA-Seq Reads to the genome with Star 
#! /bin/bash

#PBS -l walltime=24:00:00
#PBS -l nodes=1:ppn=12
#PBS -l mem=48

# ENVIRONMENT
prj=./
staridx=.${prj}INDEX_GENOME_HG38

## Make arrays named fq1 and fq2 ##
fq1=(*R1_001.fastq.gz)
fq2=(*R2_001.fastq.gz)

# COMMAND
for ((i=0;i<"${#fq1[@]}";i++)); do
	sample="${fq1[$i]%%_R*}"
	rgline="ID:${sample}    PU:${sample}    SM:${sample}    PL:ILLUMINA LB:${sample}"
	outprefix=${prj}alignment/"${sample}"
	
	echo "STAR starting alignment"
	echo "-----------------------------------"

	STAR \
	--runThreadN $Threads_choosed \
	--genomeDir $staridx \
	--outTmpDir /home/vg_lab/star_work_tmp	\
	--readFilesIn "${fq1[$i]}" "${fq2[$i]}" \
	--outFileNamePrefix $outprefix \
	--outSAMattrRGline $rgline \
	--readFilesCommand gunzip -c
	
	#Sorting
	echo "Sorting"
	date
	java -jar $picard SortSam INPUT= ${outprefix}Aligned.out.sam Output=${outprefix}_sorted_reads.bam SORT_ORDER=coordinate

	#Alignment Summary
	echo "Alignment Summary"
	date
	java -jar $picard CollectAlignmentSummaryMetrics R=$ref I= ${outprefix}_sorted_reads.bam

	date
	java -jar $picard CollectInsertSizeMetrics R=$ref I=${outprefix}_sorted_reads.bam OUTPUT=${outprefix}_insert_metrics.txt Histogram_file=${outprefix}_insert_size_histogram.pdf
done



