# README template

The purpose of this README file is to explain how the quantitative results reported in [identify research report] can be reproduced from the primary data.

## Contributors

Provide information about the citation and contact information for at least one contributor. If someone downloads this directory and forgets the original link, will they still be able to cite it?

## File requirements

Identify the files (data and analysis code) required to reproduce the results. Provide brief instructions for how to use these files to reproduce the reported results. Give a brief summary of which results are produced from which file.

### Example  

* functions.R: custom functions to be sourced into the main analysis file
* preprocessing.R: Prepare the primary data; creates data/analyze.csv
* main-analysis.Rmd: Main analyses, figures and tables
* main-analysis.html: Output of main-analysis.Rmd
* supplementary-analysis.Rmd: Supplementary analyses
* supplementary-analysis.html: Output of supplementary-analysis.Rmd
* data/primary/* : a folder of data files, one per subject
* data/analyze.csv: prepared data created by preprocessing.Rmd
* requirements.txt: A list of R packages used and versions

## Software/hardware requirements

Describe any software or hardware required to reproduce the results. If the requirements are long/complex, you can also refer to files such as Docker containers or session info output. Minimally, you should describe the version of the software you are using and any additional packages used. You should also specify any other software/hardware requirements beyond normal expectations for a typical researcher (i.e., a modern laptop running an up-to-date operating system). For example, use of a computing cluster or specialized proprietary software.

### Example

The analyses were run using R version 3.2.2. Detailed R package versions are listed in the file requirements.txt

## Memory and runtime requirements

Describe any exceptional memory and runtime requirements. For example, if the analyses take longer than an hour to run on a standard laptop/desktop computer, you should provide more details about the runtime requirements here.

### Example

preprocessing.R takes approximately 5 hours to run on an 8-core Apple MacBook Air M2 with MacOS version 14.0. main-analysis.Rmd and supplementary-analysis.Rmd take approximately 5 minutes each.

## Step-by-step instructions

Describe step-by-step how the analysis should be re-run to produce the numbers reported in the research report. Consider creating a master script that calls runs all other scripts in the necessary order — the user then only needs to run the master script.

### Example

Run preprocessing.R
Run main-analysis.Rmd
Run supplementary-analysis.Rmd
