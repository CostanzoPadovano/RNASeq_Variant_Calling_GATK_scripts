# README for RNASeq_Variant_Calling_GATK_scripts

This repository contains scripts for variant calling from RNA-Seq data using the Genome Analysis Toolkit (GATK).
Overview

RNA sequencing (RNA-Seq) is a widely used technique to study transcriptomes of organisms. It generates millions of reads that can be aligned to a reference genome to identify variants. However, variant calling from RNA-Seq data is challenging due to several factors, such as sequencing errors, mapping errors, and alternative splicing. The GATK is a widely used toolkit for variant calling that provides several best practices for variant calling from RNA-Seq data.

This repository contains scripts that implement the GATK best practices for RNA-Seq variant calling. The scripts are designed to work with paired-end RNA-Seq data and require the following inputs:

    A reference genome in FASTA format
    Paired-end RNA-Seq reads in FASTQ format
    A list of known variants in VCF format

The scripts perform the following steps:

    Alignment of RNA-Seq reads to the reference genome using STAR.
    Marking of PCR duplicates using Picard.
    Splitting of reads into exon segments using GATK SplitNCigarReads.
    Recalibration of base quality scores using GATK BaseRecalibrator and ApplyBQSR.
    Variant calling using GATK HaplotypeCaller.
    Variant filtering using GATK VariantFiltration.

## Usage

To use the scripts, clone the repository to your local machine:

git clone https://github.com/username/RNASeq_Variant_Calling_GATK_scripts.git

The scripts are organized into several files:

    align_reads.sh: Aligns RNA-Seq reads to the reference genome using STAR.
    mark_duplicates.sh: Marks PCR duplicates using Picard.
    split_reads.sh: Splits reads into exon segments using GATK SplitNCigarReads.
    recalibrate_base_quality.sh: Recalibrates base quality scores using GATK BaseRecalibrator and ApplyBQSR.
    call_variants.sh: Calls variants using GATK HaplotypeCaller.
    filter_variants.sh: Filters variants using GATK VariantFiltration.
    run_pipeline.sh: Runs the entire variant calling pipeline.

To run the pipeline, modify the parameters in run_pipeline.sh to match the paths to your input files and the desired output directory. Then, run the pipeline using the following command:

bash run_pipeline.sh

The pipeline will generate a VCF file containing the called variants in the output directory.
Dependencies

The scripts require the following software to be installed:

    STAR (v2.5.3a or later)
    Picard (v2.10.0 or later)
    GATK (v4.0.0.0 or later)
