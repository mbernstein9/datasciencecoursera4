# download data
setwd("/Users/FTS/Desktop/Coursera/04_Exploratory_Data_Analysis/scripts")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./data/download001.zip", method="curl")
list.files("./data")

# unzip data
unzip("./data/download001.zip", list=FALSE)
list.files("./")

# load data and subset data
rawdata <- read.csv("household_power_consumption.txt", sep=";", header=TRUE)
subdata <- rawdata[which(as.Date(rawdata$Date, "%d/%m/%Y") == "2007-02-01" | as.Date(rawdata$Date, "%d/%m/%Y") == "2007-02-02"),]
plotdata <- cbind(data.frame(strptime(paste(subdata$Date, subdata$Time), "%d/%m/%Y %H:%M:%S"))
                  , data.frame(as.double(as.character(subdata$Global_active_power)))
                  , data.frame(as.double(as.character(subdata$Voltage)))
                  , data.frame(as.double(as.character(subdata$Global_reactive_power)))
                  , data.frame(as.double(as.character(subdata$Sub_metering_1)))
                  , data.frame(as.double(as.character(subdata$Sub_metering_2)))
                  , data.frame(as.integer(as.character(subdata$Sub_metering_3))))
names(plotdata) <- c("date_time", "global_active_power", "voltage", "global_reactive_power", "sub_metering_1", "sub_metering_2", "sub_metering_3")

# plot data
par(mfrow = c(2, 2))
with(plotdata, {
  plot(x=date_time, y=global_active_power , type= "l", main = "", xlab="" , ylab = "Global Active Power")
  plot(x=date_time, y=voltage, type= "l", main = "", xlab="datetime" , ylab = "Voltage")
  plot(x=plotdata$date_time, y=plotdata$sub_metering_1, type= "l", xlab="" , ylab = "Energy sub metering")
  lines(x=plotdata$date_time, y=plotdata$sub_metering_2, col="red")
  lines(x=plotdata$date_time, y=plotdata$sub_metering_3, col="blue")
  legend("top", bty = "n", inset = 0, cex = 0.8, lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(x=date_time, y=global_reactive_power, type= "l", main = "", xlab="datetime" , ylab = "Global_reactive_power")
})

# copy to png
dev.copy(png, file = "plot4.png", bg = "white", width=480, height=480)
dev.off()
