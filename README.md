==================================================================
Human Activity Recognition Using Smartphones Dataset
====================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- It's activity name
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================
- 'README.txt'
- 'TidyDataSamsungGalaxy.txt' data set
- 'run_analysis.rmd'
- 'run_analysis.html'
- 'run_analysis.r'

Steps to reproduce this project
===============================
1. Open the R script run_analysis.r using RStudion.
2. Call the function run_analysis() and provide it the path for the folder "UCI HAR Dataset" or you can put the folder in your defualt working directory and it will reach it directly (Note: Default Directory works only with Linux users)
3. Optional for Mac/Windows Users
   + Open the R script run_analysis.r using a text editor.
   + edit the argument for "run_analysis()" function with the folder path of the "UCI HAR Dataset" folder


Description
========================================
The purpose of this function is to clean the data coming from the accelerometers from the Samsung Galaxy S smartphone.

