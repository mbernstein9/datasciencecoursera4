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

# plot data
hist(as.double(as.character(subdata$Global_active_power)), main = "Global Active Power",  xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")
dev.copy(png, file = "plot1.png")
dev.off()
