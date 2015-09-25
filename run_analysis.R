run_analysis<- function(folderPath="~/UCI HAR Dataset"){
    library(dplyr)
    library(data.table)
    #### AT first we read the data from the files 
    #### with names (X_train,X_test,Subject_train,Y_train,
    #### Subject_test,Y_test,features)
    X_train <- read.table( paste(folderPath,"/train/X_train.txt", sep = ""))
    X_test <- read.table(paste(folderPath,"/test/X_test.txt", sep = ""))
    Subject_Train <- read.table(paste(folderPath,"/train/subject_train.txt", sep = ""))
    Y_train <- read.table(paste(folderPath,"/train/y_train.txt", sep = ""))
    Subject_Test <- read.table(paste(folderPath,"/test/subject_test.txt", sep = ""))
    Y_test <- read.table(paste(folderPath,"/test/y_test.txt", sep = ""))
    features <- read.table(paste(folderPath,"/features.txt", sep = ""))
    ColumnsNames <- as.array.default(features$V2) #we read in variables names
    ColumnsNames <- as.character(ColumnsNames)
    
    
    ##########################################################
    #### In the Coming steps we extract the needed columns
    #### that contains "mean" or "std"
    counter <- 1
    NeededColumns <- NULL 
    for (x in ColumnsNames) {
        if(grepl("mean",x)  ){
            NeededColumns<- c(NeededColumns,counter)
        }
        counter <- counter + 1
    }
    counter <- 1
    for (x in ColumnsNames) {
        if( grepl("std",x) ){
            NeededColumns<- c(NeededColumns,counter)
        }
        counter <- counter + 1
    }
    #### Here subset only the columns we need with the index
    #### we have got from the previous Loob
    X_train<- X_train[,NeededColumns] ##subsetting data
    X_test <- X_test[,NeededColumns]  ##subsetting data
    ColumnsNames<- ColumnsNames[NeededColumns] ##subsetting Columns Names
    merged_train <- cbind(Subject_Train,Y_train,X_train) ##merging the file Subject_Train with X_train with Y_train
    merged_test <- cbind(Subject_Test,Y_test,X_test) ##merging the file Subject_test with X_test with Y_test
    merged_TT <- rbind(merged_train,merged_test) ## here we merge Test data with train data
    ColumnsNames <- append(c("Subject","ActivityNumber"),ColumnsNames) 
    colnames(merged_TT) <- ColumnsNames   ## Naming columns
    
    
    ########################################################
    #### Here we started to replace every Activity Number
    #### with Activity name putting the new data in Activity
    ActivityName<- NULL
    counter <- 1
    for(x in merged_TT[,2]){
        if(x==1)
            ActivityName <- c(ActivityName,"WALKING")
        else if(x==2)
            ActivityName <- c(ActivityName,"WALKING_UPSTAIRS")
        else if(x==3)
            ActivityName <- c(ActivityName,"WALKING_DOWNSTAIRS")
        else if(x==4)
            ActivityName <- c(ActivityName,"SITTING")
        else if(x==5)
            ActivityName <- c(ActivityName,"STANDING")
        else if(x==6)
            ActivityName <- c(ActivityName,"LAYING")
        else{
            break("label out of order")
        }
        counter <- counter + 1
    }
    
    
    #########################################################
    #### Here we subset the second raw of the activity number
    #### and replace it with the activity name that we got
    #### from the previous loob and stored in variable Activity
    #### At the aggregate function we are getting the mean for
    #### every Activity for every subject
    merged_TT <- cbind(merged_TT[1:2],ActivityName,merged_TT[3:81])
    FinalData <- aggregate(merged_TT[4:82],list(Subject = merged_TT$Subject,ActivityName=merged_TT$ActivityName,ActivityNumber=merged_TT$ActivityNumber),mean)
    FinalData <- arrange(FinalData,Subject,ActivityNumber)
    
    
    ########################################################
    #### Here we will give variables decriptive names
    #### And at the last step we write the data in .txt file 
    names(FinalData)<-gsub("std()", "SD", names(FinalData))
    names(FinalData)<-gsub("mean()", "MEAN", names(FinalData))
    names(FinalData)<-gsub("^t", "Time", names(FinalData))
    names(FinalData)<-gsub("^f", "Frequency", names(FinalData))
    names(FinalData)<-gsub("Acc", "Accelerometer", names(FinalData))
    names(FinalData)<-gsub("Gyro", "Gyroscope", names(FinalData))
    names(FinalData)<-gsub("Mag", "Magnitude", names(FinalData))
    names(FinalData)<-gsub("BodyBody", "Body", names(FinalData))
    write.table(FinalData,"~/TidyDataSamsungGalaxy.txt",row.names = FALSE)
}
