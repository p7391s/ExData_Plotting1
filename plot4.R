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

##convert the date variable to date class

EPCfull$Date <- as.Date(EPCfull$Date, format="%d/%m/%Y")

## subset the data

epc <- subset(EPCfull, subset=(Date >= "2007-02-01" & Date < "2007-02-03"))
head(epc,3)
rm(EPCfull)

## dates and times

datetime <- paste(as.Date(epc$Date), epc$Time)
epc$datetime <- as.POSIXct(datetime)


## create png device

png("plot4.png", width = 480, height = 480)


## time setup

Sys.setlocale("LC_TIME", "English")

## create plot 4

par(mfrow = c(2,2))

          plot(epc$Global_active_power ~ epc$datetime, type="l",
               ylab="Global Active Power", xlab="")
          plot(epc$Voltage ~ epc$datetime, type="l",
               ylab="Voltage", xlab="datetime")
          plot(epc$Sub_metering_1 ~ epc$datetime, type="l",
               ylab="Energy sub metering", xlab="")
          lines(epc$Sub_metering_2 ~ epc$datetime, col="Red")
          lines(epc$Sub_metering_3 ~ epc$datetime, col="Blue")
          legend("topright",lty=1, col=c("black","red","blue"),
                 legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
          plot(epc$Global_reactive_power ~ epc$datetime, type="l",
               ylab="Global_reactive_power", xlab="datetime")



## close device

dev.off()
