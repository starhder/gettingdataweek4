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
