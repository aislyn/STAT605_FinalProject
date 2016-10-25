library(stringr)
library(readr)
library(dplyr)

#folder path of your files
folder <- "/Users/BobaFett/Desktop/STAT_605/final_project/test/"

#set's the working directory to this path (for no reason really)
setwd(folder)

#list of files in the folder
file_list <- list.files(folder)

#list of only the .csv files
#this can be changes to .xlxs,
#but I'm not sure if R can read them
csv_list <- file_list[str_detect(file_list, fixed(".csv"))] 


for (csv in csv_list){
  #extracts a 5 digit number from the file name
  #assuming that it's a zipcode
  zipcode <- str_extract(csv, "([0-9]{5})")
  
  # if the merged dataset doesn't exist, create it
  if (!exists("dataset")){
    #this line might need tweeking
    #especially if not a csv
    dataset <- read_delim(csv, col_names = TRUE, delim=",")
    dataset$zipcode = zipcode
  }
  # otherwise if the merged dataset does exist, append to it
  else if (exists("dataset")){
    #this line too
    temp_dataset <- read_delim(csv, col_names = TRUE, delim=",")
    temp_dataset$zipcode = zipcode
    #rowbind them
    dataset <- rbind(dataset, temp_dataset)
    #remove it for the next turn
    #not really nescessary
    rm(temp_dataset)
  }
  print(dataset)
}

#write the merged csv's up one folder 
write_csv(dataset, path = "../merged_data.csv")

#run this if you want dataset
#to be empty again
#otherwise it will keep appending
#rm(dataset)



