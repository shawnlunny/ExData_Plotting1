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

#create device
png("plot1.png")

#write histogram to device
hist(power$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

#close device
dev.off()