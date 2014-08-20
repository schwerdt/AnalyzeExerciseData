run_analysis <- function(  )  {

     #Get to UCI HAR Dataset directory
     setwd('UCI HAR Dataset/')
     #First read in the test and training data sets
     #test directory first
     setwd('./test')
     #Read in subject data
     subject_test <- read.table('subject_test.txt',sep="\n",header=F)
     x_test <- read.table('X_test.txt',header=F)
     y_test <- read.table('y_test.txt',sep="\n",header=F)
  
     #Go to the training directory     
     setwd('../train')
     #Read the subject_train, X_train, y_train data
     subject_train <- read.table('subject_train.txt',sep="\n",header=F)
     x_train <- read.table('X_train.txt',header=F)
     y_train <- read.table('y_train.txt',sep="\n",header=F)
 
     #Go back to the UCI directory
     setwd('../')
      
     #Join the testing and training data sets (test first, then train)
     subject_total <- rbind(subject_test,subject_train)
     x_total <- rbind(x_test,x_train)
     y_total <- rbind(y_test,y_train)
     
     #Create a data frame for the data
     all_data <- data.frame(subject_total,y_total,x_total)
     #Create a vector with the column names for the data frame
     names_from_file <- read.table('features.txt',sep=" ",header=F)
     names_from_file <- as.character(names_from_file$V2)
     all_names <- append(c("Subject_ID","Activity_ID"),names_from_file)
 
     #Name the columns of the all_data data.frame with title in the all_names vector
     colnames(all_data) <- all_names

     #We want to return the columns that contain means and standard deviations
     index_of_means <- grep("mean()",fixed=TRUE,colnames(all_data))
     index_of_stddev <- grep("std()",fixed=TRUE,colnames(all_data))
     index_of_means_stddev <- append(index_of_means,index_of_stddev)
     #Create a new data frame with subject_id, activity_id, means, standard deviations
     mean_and_stddev <- data.frame("Subject_ID"=subject_total[,1],"Activity_ID"=y_total[,1])
     mean_and_stddev_colnames <- c("Subject_ID","Activity_ID")

     #Loop over the index_of_means and index_of_stdev and append those columns to the data frame.
     for(i in 1:length(index_of_means_stddev)) {
         old_col_index <- index_of_means_stddev[i]
         col_name <- names(all_data)[old_col_index]
         mean_and_stddev_colnames <- append(mean_and_stddev_colnames,col_name)
         mean_and_stddev[,i+2] <- all_data[,old_col_index]
     }

     #Name the columns in the data frame
     colnames(mean_and_stddev) <- mean_and_stddev_colnames
#-----------------------Checked through here


      #Get the labels for activity IDs
      activity_labels <- read.table('activity_labels.txt',sep=" ",header=F)
      names(activity_labels) <- c("Activity_ID","Activity_Name")

      library(sqldf)
      #This data frame (activity_name_labels) contains the subject ID and the activity name (instead of number ID)
      activity_name_labels <- sqldf("select Subject_ID, Activity_Name from mean_and_stddev inner join activity_labels using(Activity_ID)")
      
      #Replace the Activity_ID column in the mean_and_stddev data frame with the Activity_Name column
      mean_and_stddev$Activity_ID <- activity_name_labels$Activity_Name
      names(mean_and_stddev)[2] <- "Activity_Name"
#---------------------Checked through here

      #Split the data frame by Activity_Name
      by_activity <- split(mean_and_stddev,mean_and_stddev$Activity_Name)
      
      ncols <- NCOL(mean_and_stddev)
      #Create the data frame for averages
      All_Averages <- data.frame(t(rep(NA,ncols)))
      #Name the columns the same as they are in the mean_and_stddev data frame
      names(All_Averages) <- names(mean_and_stddev)
      #Remove the NA values
      All_Averages <- All_Averages[-1,]
#--------------------Checked through here

      count = 1
      number_of_subjects <- max(mean_and_stddev[,1])

      #Loop over activities
      for(i in 1:NROW(activity_labels)) {
          #Break the by_activity data up by subject
          activity_name <- activity_labels[i,2]
          by_activity_thensubject <- split(by_activity[[activity_name]], by_activity[[activity_name]]$Subject_ID)
          #Loop over each subject
          for(subject_num in 1:number_of_subjects) {
              All_Averages[count,1] <- subject_num
              All_Averages[count,2] <- as.character(activity_name)  #activity_name is a factor
              #Loop over columns in the mean/stddev data frame and compute the mean for each column 
              #(excluding Subject_ID and Activity_Name columns)
              for(col_num in 3:NCOL(mean_and_stddev)) {
                  temp_mean <- mean(by_activity_thensubject[[subject_num]][,col_num]) 
                  All_Averages[count,col_num] <- temp_mean
              }
          count <- count + 1
         }
     }

         #Write the All_Averages data frame (which contains means of all means and standard deviations 
         #in the original dataset)
         setwd('../')
         write.table(All_Averages,file='TidyAverages.txt',row.names=FALSE,quote=FALSE)

         return(All_Averages)

}
 

#           #Another possible way:
#           library(plyr)
#           library(reshape2)
#           melted <- melt(mean_and_stddev,id.vars=c("Subject_ID","Activity_Name"))
#           #Gives a data frame with same 
#           #Subject_ID, Activity_Name, variable (which were old column names in mean_and_stddev), value   
#           ddply(melted,c("Subject_ID","Activity_Name","variable"),summarize,mean=mean(value),stddev= sd(value))  
#           #Can add whatever functions you want applied to value
#           #Gives a data frame with four columns
#           #Subject_ID, Activity_Name, variable (old column names from mean_and_stddev), mean


