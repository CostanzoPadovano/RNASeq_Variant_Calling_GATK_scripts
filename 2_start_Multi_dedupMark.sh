#!/bin/bash

echo "1R-1068217"
cd 1R-1068217
cd alignment

java -jar ../../Script_run/picard.jar MarkDuplicates INPUT= 1R-1068217_S1_L001_sorted_reads.bam INPUT= 1R-1068217_S1_L002_sorted_reads.bam INPUT= 1R-1068217_S1_L003_sorted_reads.bam INPUT= 1R-1068217_S1_L004_sorted_reads.bam OUTPUT= 1R-1068217_sample_dedup_reads.bam METRICS_FILE=metrics.txt

echo "finished 1R-1068217"
cd ..
cd ..