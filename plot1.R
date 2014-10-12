#download file if it doesn't exist yet
if (!file.exists("household_power_consumption.txt")) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, "power.zip")
  unzip("power.zip")      
}

#read data from file
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", dec = ".", col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"), colClasses = c("character", "character", rep("numeric",7)))

#Transform column Date to date type
data$Date <- as.Date(data$Date, format = '%d/%m/%Y')

#subsetting data for time period from 2007-02-01 to 2007-02-02
graphData <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

#switch on device
png("plot1.png")

#create red histogram
hist(graphData$Global_active_power, col = 10, main = paste("Global Active Power"), xlab = "Global Active Power (kilowatts)")

#switch off device
dev.off()