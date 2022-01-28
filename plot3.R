library("datasets")
library("graphics")
library("grDevices")
library("utils")
library("methods")
library("stats")
library("lubridate")

if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/exdata_data_household_power_consumption.zip", method="curl")
unzip(zipfile = "./data/exdata_data_household_power_consumption.zip", exdir = "./data")

householdPowerData = read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

#credit to Mauricio Vasquez for example of conversion to DateTime (https://www.coursera.org/learn/exploratory-data-analysis/discussions/forums/lSpQbyj3EeaZ8Apto8QB_w/threads/2tnkfMoIEeWwyg7SJZ3bgQ)
householdPowerData$DateTime <- strptime(paste(householdPowerData$Date, householdPowerData$Time), format="%d/%m/%Y %H:%M:%S")

householdPowerData$Date = as.Date(householdPowerData$Date,"%d/%m/%Y")
plotData = householdPowerData[as.Date("2007-02-01") <= householdPowerData$Date & householdPowerData$Date <= as.Date("2007-02-02"), ]

png(file = "plot3.png")
plot(plotData$DateTime, plotData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(plotData$DateTime, plotData$Sub_metering_2, col = "red")
lines(plotData$DateTime, plotData$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

