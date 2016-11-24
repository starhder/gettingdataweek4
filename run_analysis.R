# Downlaods the data file and unzip, after running this function, there's a 
# "UCI HAR Dataset" folder in your working directory. The unzipped data are
# in that folder.
preparedatafile <- function() {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                "dataset.zip")
  unzip("dataset.zip")
}

# Gets the features required in the assignemnt, i.e. means and standard
# deviations.
cleanfeaturenames <- function() {
  feature_name_file <- file.path("UCI HAR Dataset", "features.txt")
  feature_names <- read.table(feature_name_file, colClasses = "character")[,2]
  feature_names[grep("mean\\(\\)|std\\(\\)", feature_names)]
}

# Gets the activity names from the data set.
activitynames <- function() {
  act_name_file <- file.path("UCI HAR Dataset", "activity_labels.txt")
  read.table(act_name_file, colClasses = "factor")[,2]
}

# Reads the dataset (either "train" or "test") and join, including features,
# labels (activities) and subjects. It also
#  - joins the data to a single dataframe
#  - replaces activities with names
readjoinandclean <- function(data_set) {
  if (data_set != "train" && data_set != "test") {
    stop("data_set should be either 'train' or test")
  }
  base_folder <- "UCI HAR Dataset"
  sub_file <- file.path(base_folder, data_set, paste0("subject_", data_set, ".txt"))
  sub_data <- read.table(sub_file, colClasses = "factor")
  names(sub_data) <- "subject"
  
  feature_file <- file.path(base_folder, data_set, paste0("X_", data_set, ".txt"))
  feature_data <- read.table(feature_file)
  feature_name_file <- file.path(base_folder, "features.txt")
  feature_names <- read.table(feature_name_file, colClasses = "character")[,2]
  names(feature_data) <- feature_names
  cleannames <- feature_names[grep("mean\\(\\)|std\\(\\)", feature_names)]
  feature_data <- feature_data[, cleannames]

  label_file <- file.path(base_folder, data_set, paste0("y_", data_set, ".txt"))
  label_data <- read.table(label_file)
  names(label_data) <- "activity"
  label_data[,1] <- activitynames()[label_data[,1]]

  cbind(sub_data, label_data, feature_data)
}

# Reads both "train" and "test" dataset, and return the joined dataframe.
readall <- function() {
  rbind(readjoinandclean("train"), readjoinandclean("test"))
}

# Run the assignment end to end, and put the result to out_file.
# Note: by default the it skips download step because it takes long time.
endtoend <- function(out_file = "result.txt", download = F) {
  if (download) {
    preparedatafile()
  }
  dat <- readall()
  cf <- cleanfeaturenames()
  res<-aggregate(dat[cf], 
                 by = list(subject = dat$subject,
                           activity = dat$activity), 
                 mean)
  write.table(res, out_file, row.names = F)
}
