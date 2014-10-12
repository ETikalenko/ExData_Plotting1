#download file if it doesn't exist yet
if (!file.exists("household_power_consumption.txt")) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, "power.zip")
  unzip("power.zip")      
}

#read data from file
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", dec = ".", col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"), colClasses = c("character", "character", rep("numeric",7)))

#add new column "DT" in data.frame and transform it to date type
data$DT <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

#subsetting data for time period from 2007-02-01 to 2007-02-02
graphData <- data[data$DT >= "2007-02-01 00:00:00" & data$DT <= "2007-02-02 23:59:59",]

#switch on device
png("plot4.png")
par(mfrow = c(2,2))
with(graphData, {
  plot(DT, Global_active_power, type ="l", xlab = "", ylab = "Global Active Power")
  plot(DT, Voltage, type ="l", xlab = "datetime")
    with(graphData, plot(DT, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
    with(graphData, lines(DT, Sub_metering_1, col = "black"))
    with(graphData, lines(DT, Sub_metering_2, col = "red"))
    with(graphData, lines(DT, Sub_metering_3, col = "blue"))
    legend("topright", bty = "n", lwd = 1, cex = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(DT, Global_reactive_power, type = "l", xlab = "datetime")
})
dev.off()




