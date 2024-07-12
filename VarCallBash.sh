#!/bin/bash

# Usage function
usage() {
    echo "Usage: $0 -r <reference_genome.fa> -1 <read1.fastq> -2 <read2.fastq> -o <output_directory>"
    echo "Options:"
    echo "  -r <reference_genome.fa>: Path to reference genome FASTA file"
    echo "  -1 <read1.fastq>: Path to first paired-end read FASTQ file"
    echo "  -2 <read2.fastq>: Path to second paired-end read FASTQ file"
    echo "  -o <output_directory>: Directory to store output files"
    exit 1
}

# Parse command-line options
while getopts ":r:1:2:o:h" opt; do
    case ${opt} in
        r)
            ref_genome=$OPTARG
            ;;
        1)
            read1=$OPTARG
            ;;
        2)
            read2=$OPTARG
            ;;
        o)
            output_dir=$OPTARG
            ;;
        h)
            usage
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            usage
            ;;
        :)
            echo "Option -$OPTARG requires an argument."
            usage
            ;;
    esac
done

# Check if required arguments are provided
if [[ -z $ref_genome || -z $read1 || -z $read2 || -z $output_dir ]]; then
    echo "Error: Missing arguments!"
    usage
fi

# Create output directory if it doesn't exist
mkdir -p $output_dir

# Step 1: Align reads to reference genome
echo "Aligning reads to reference genome..."
bwa mem -t 4 $ref_genome $read1 $read2 | samtools view -bS - > $output_dir/aligned_reads.bam

# Step 2: Sort and index BAM file
echo "Sorting and indexing BAM file..."
samtools sort -@ 4 $output_dir/aligned_reads.bam -o $output_dir/sorted_reads.bam
samtools index $output_dir/sorted_reads.bam

# Step 3: Variant calling with GATK
echo "Calling variants..."
gatk HaplotypeCaller -R $ref_genome -I $output_dir/sorted_reads.bam -O $output_dir/raw_variants.vcf

# Step 4: Variant filtering
echo "Filtering variants..."
gatk VariantFiltration -R $ref_genome -V $output_dir/raw_variants.vcf -O $output_dir/filtered_variants.vcf --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0" --filter-name "basic_filter"

echo "Variant calling pipeline completed!"


