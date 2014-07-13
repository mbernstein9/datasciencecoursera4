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
plotdata <- cbind(data.frame(strptime(paste(subdata$Date, subdata$Time), "%d/%m/%Y %H:%M:%S")), data.frame(as.double(as.character(subdata$Global_active_power))))
names(plotdata) <- c("date_time", "global_active_power")

# plot data
plot(x=plotdata$date_time, y=plotdata$global_active_power , type= "l", main = "Global Active Power", xlab="" , ylab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png", width=480, height=480)
dev.off()
