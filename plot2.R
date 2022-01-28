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

png(file = "plot2.png")
with(plotData, plot(DateTime,Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
dev.off()

