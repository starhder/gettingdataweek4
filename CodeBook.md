# Code Book: run_analysis.R explanation

## Function List
 - endtoend(): runs the script to generate the requested dataframe and write to a file.
   To turn on the download, set download = TRUE. Setting download = FALSE because it 
   requires network connection and takes a while.
 - preparedatafile(): downloads and unzips the file. This should be a one-off function.
 - readall(): reads all the data and join, it calls readjoinandclean() twice for "train" 
   and "test" data.
 - readjoinandclean(): Reads the dataset (either "train" or "test") and join, including
   features, labels (activities) and subjects. It also
   * joins the data to a single dataframe
   * replaces activities with names
 - cleanfeaturenames(): is a helper function, gets all the mean and sd feature names.
 - activitynames(): is a helper function, gets all the activity names().

## Varaibles/Parameters
Please also check the code for parameter details. If the function is not listed, there's no
parameter for that function
### endtoend
 - out_file: which file will the data table write to.
 - download: if TRUE, download the data file from internet first.
### readjoinandclean
 - dataset: either "train" or "test", it's the corresponding dataset to read.

## Howto
### Generate the result data
 - endtoend(download = TRUE) will generate the result from scratch (you need network connection).
   By default the "result.txt", alter out_file paramter to change output filename.
 - To play with the dataframe: run preparedatafile() once, then assign readall() to some variable.
 
## Contact
  Contact starhder@gmail.com if you have any questions.
