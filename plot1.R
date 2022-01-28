library("datasets")
library("graphics")
library("grDevices")
library("utils")
library("methods")
library("stats")

if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/exdata_data_household_power_consumption.zip", method="curl")
unzip(zipfile = "./data/exdata_data_household_power_consumption.zip", exdir = "./data")

householdPowerData = read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
householdPowerData$Date = as.Date(householdPowerData$Date,"%d/%m/%Y")
plotData = householdPowerData[as.Date("2007-02-01") <= householdPowerData$Date & householdPowerData$Date <= as.Date("2007-02-02"), ]

png(file = "plot1.png")
hist(plotData$Global_active_power, main = "Global Active Power", col="red", xlab = "Global Active Power (kilowatts)")
dev.off()

