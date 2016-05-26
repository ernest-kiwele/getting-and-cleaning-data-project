# getting-and-cleaning-data-project
Repository used for the data science course project 'getting and cleaning data'


This repository contains a script that tidies the dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
The details of th resulting data set can be found in the file code-book.md.
The script performing the data cleaning is in file getdata.R. Instructions to be followed in order to execute the script are below.

## Executing the data cleanup script
To clean up the original data from UCI, follow these steps:

### File download
The script can automatically download the archive from the source. If this is not desired, comment out the script line starting with download.file
If the file has already been manually downloaded, ensure that it is stored in the working directory with the name 'dataset.zip'.

## Executing
Source the file in R and the transformations will occur, with optional file download.
At the end of execution, the resulting data set is stored in the current directory with the name 'finaldataset.txt'.

## Removing temporary data
The script extracts the archive to a temporary folder called 'data', under the working directory. After execution, this folder can be removed.


## Details of transformations
Please refer to detailed comments in the script file for information on each step taken to tidy up the data set.
