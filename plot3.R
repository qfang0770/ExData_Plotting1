# set working dir
setwd("~/Desktop/JHU/explortary")

# download file
fileName = "exdata-data-household_power_consumption.zip"
if(!file.exists(fileName)){
  fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL,fileName,method = "curl")
}

# unzip file
if(!file.exists("household_power_consumption.txt")){
  unzip(fileName)
}

# read file
data= read.table("household_power_consumption.txt",header = TRUE, sep = ";", na.strings = "?")

# def subset
data$Date = as.Date(as.character(data$Date),"%d/%m/%Y")
dataset = subset(data,data$Date=="2007-02-01"|data$Date=="2007-02-02")
dataset$timeStamp = as.POSIXct(paste(dataset$Date,dataset$Time),format = "%Y-%m-%d %H:%M:%S")

png("plot3.png",width = 480, height = 480)
plot(dataset$timeStamp,dataset$Sub_metering_1,type = "l", col = 1, xlab = "", ylab = "Energy Submetering")
lines(dataset$timeStamp,dataset$Sub_metering_2,type = "l", col = 2)
lines(dataset$timeStamp,dataset$Sub_metering_3,type = "l", col = 4)
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c(1,2,4))
dev.off()
