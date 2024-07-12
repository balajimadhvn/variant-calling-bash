# Variant Calling Pipeline in Bash

This repository contains a Bash script that automates a variant calling pipeline for analyzing next-generation sequencing (NGS) data. The pipeline includes read alignment, variant calling, and basic filtering steps using widely used bioinformatics tools.

## Features

- **Alignment**: Aligns paired-end reads to a reference genome using BWA.
- **Variant Calling**: Uses GATK (HaplotypeCaller) to identify variants (SNPs and INDELs).
- **Variant Filtering**: Applies basic filtering criteria (QD < 2.0, FS > 60.0, MQ < 40.0) to raw variants using GATK VariantFiltration.

## Requirements

- **Bash**: The script is written in Bash and requires a Unix-like environment.
- **BWA**: Burrows-Wheeler Aligner for read alignment.
- **SAMtools**: Utilities for manipulating SAM/BAM files.
- **GATK**: Genome Analysis Toolkit for variant calling and filtering.

Ensure these tools are installed and accessible via the command line before running the pipeline.

## Usage

1. **Clone the repository:**

   ```bash
   git clone https://github.com/balajimadhvn/variant-calling-bash.git
   cd variant-calling-bash
   ```

2. **Run the variant calling pipeline:**

   ```bash
   ./variant_calling_pipeline.sh -r /path/to/reference_genome.fa -1 /path/to/read1.fastq -2 /path/to/read2.fastq -o /path/to/output_directory
   ```

   Replace `/path/to/` with the actual paths to your reference genome, FASTQ files (paired-end reads), and desired output directory.

3. **Output:**

   - The pipeline will generate `sorted_reads.bam` (sorted BAM file), `raw_variants.vcf` (raw variants), and `filtered_variants.vcf` (filtered variants) in the specified output directory.

## Example

For a quick test with example data included in this repository:

```bash
./variant_calling_pipeline.sh -r example_data/reference.fa -1 example_data/read1.fq -2 example_data/read2.fq -o output
```

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please feel free to create an issue or fork the repository and submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

### Notes:

- Customize the paths and commands in the README according to your project structure and requirements.
- Provide specific instructions for setup, usage, and testing to help users understand and utilize your variant calling pipeline effectively.
- Include information about how to contribute to encourage collaboration and improvement of your project.

This README provides a clear overview of your variant calling pipeline, how to use it, and how to contribute, making it easier for others to understand and engage with your project on GitHub. Adjust it further based on specific details or additional features of your pipeline.
