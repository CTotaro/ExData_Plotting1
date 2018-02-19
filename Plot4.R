#Plot 4
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

dev.off()
# Create combined plot structure
par(mfcol=c(2,2))

# Drop in the first plot
plot(x=plotdata$DateTime, y=plotdata$Global_active_power, type="l", 
     main = "", 
     ylab = "Global Active Power (kilowatts)",
     xlab="")
# Drop in the second plot
plot(x=plotdata$DateTime, y=plotdata$Sub_metering_1, 
     xlab="",ylab="Energy sub metering",
     type="n")
lines(x=plotdata$DateTime, y=plotdata$Sub_metering_1)
lines(x=plotdata$DateTime, y=plotdata$Sub_metering_2, col="red")
lines(x=plotdata$DateTime, y=plotdata$Sub_metering_3, col="blue")
legend("topright", 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1, bty="n",
       col=c("black","red","blue"))
# Drop inthe third plot
plot(x=plotdata$DateTime, y=plotdata$Voltage, type="l", 
     main = "", 
     ylab = "Voltage",
     xlab="datetime")
# Drop in the fourth plot
plot(x=plotdata$DateTime, y=plotdata$Global_reactive_power, type="l", 
     main = "", 
     ylab = "Global_reactive_power",
     xlab="datetime")

# Copy to a .PNG file
dev.copy(png, file = "plot4.png")
dev.off()
