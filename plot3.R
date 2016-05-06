#download the zip file from the source and unzip it
destFile="household_power_consumption.txt"

if(!file.exists(destFile)){
  zipFile = "household_power_consumption.zip";
  download.file(paste("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/", sep="", zipFile), zipFile)
  unzip(zipFile)
}
#Note: You cannot skip lines and also read the header so we do it in two steps

#read the header line from the file
header <- read.table(destFile, sep=";", stringsAsFactors=FALSE, nrows=1)
#read only the lines from 2-1-2007 through 2-2-2007 (2880 rows)
power <- read.table(destFile, sep=";", na.strings="?", stringsAsFactors=FALSE, skip=66637, nrows=2880)
#set the variable names
colnames(power) <- unlist(header)

#merge the Date and Time columns into a DateTime column
power$Datetime <- strptime(paste(power$Date, sep=" ", power$Time), "%d/%m/%Y %H:%M:%S")

#we joined Date and Time togeter as a DateTime so we can remove those columns
power <- subset(power, select= -c(Date, Time))

#create device
png("plot3.png")

#write plot to device
plot(power$Datetime, power$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
points(power$Datetime, power$Sub_metering_2, type="l", col="red")
points(power$Datetime, power$Sub_metering_3, type="l", col="blue")
#add legend
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1 , col=c("black", "red", "blue"))

#close device
dev.off()