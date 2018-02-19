#Plot 1
setwd("C:/Users/Christopher/R/Coursera/Course4/ExData_Plotting1")

# These packages are necessary to use the read.csv.sql() function, which allows
# me to extract select rows from the raw data set. 
install.packages("sqldf")
install.packages("RSQLite")
install.packages("bit")
library("bit")
library("RSQLite")
library("sqldf")
library("lubridate")

# URL of the raw data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download raw data to working directory using URL
download.file(url = fileURL, destfile = "C:/Users/Christopher/R/Coursera/Course4/ExData_Plotting1household_power_consumption.txt")

# Extract only the usable data and store it in an R dataframe
plotdata <- read.csv.sql("household_power_consumption.txt", 
                     header= TRUE,
                     sql = "select * from file where Date = '1/2/2007' or Date =
                     '2/2/2007' ", 
                     sep = ";")
# Concatenate Date and Time into a single column
plotdata$DateTime <- paste(plotdata$Date, plotdata$Time)

# Convert char vector to date. NOTE: format must match the existing format in x,
# NOT the desired format of the conversion
plotdata$DateTime <- strptime(plotdata$DateTime, "%d/%m/%Y %H:%M:%S")

# Plot the desired plot
hist(plotdata$Global_active_power, col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency",
     xaxt="n") #prevent hist() from plotting any x parameters

# Set axis values
axis(1,at=c(0,2,4,6),labels=TRUE,tick=TRUE)

# Copy to a .PNG file
dev.copy(png, file = "plot1.png")
dev.off()
