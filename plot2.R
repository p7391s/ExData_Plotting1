## load the library

library("data.table")

## get the path to the working directory

path <- getwd()

## url zip file

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## download file

download.file(url, file.path(path, "data_files.zip"))

## unzip file

unzip(zipfile = "data_files.zip")

## read in data from file

EPCfull <- data.table::fread(input = "household_power_consumption.txt",
	na.strings = "?"
	)

## convert the date variable to date class

EPCfull$Date <- as.Date(EPCfull$Date, format="%d/%m/%Y")

## subset the data

epc <- subset(EPCfull, subset=(Date >= "2007-02-01" & Date < "2007-02-03"))
head(epc,3)
rm(EPCfull)

## dates and times

datetime <- paste(as.Date(epc$Date), epc$Time)
epc$datetime <- as.POSIXct(datetime)

## create png device

png("plot2.png", width = 480, height = 480)


## time setup

Sys.setlocale("LC_TIME", "English")

## create plot 2

plot(epc$Global_active_power ~ epc$datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")

## close device

dev.off()