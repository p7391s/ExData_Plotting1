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

powerDT <- data.table::fread(input = "household_power_consumption.txt",
	na.strings = "?"
	)

## prevents histogram from printing

powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

## Change date to date type

powerDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

## filter dates

powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

## create output device

png("plot1.png", width = 480, height = 480)

## draw a histogram

hist(powerDT[, Global_active_power], main = "Global Active Power",
	xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")

## close output device

dev.off()
