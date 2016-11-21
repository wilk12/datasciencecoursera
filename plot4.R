temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
mydata <- read.csv(unz(temp,"household_power_consumption.txt"), sep=";", stringsAsFactors = FALSE)
unlink(temp)

mydata$Date <- as.Date(mydata$Date, format = "%d/%m/%Y")
mydata <- mydata[mydata$Date>="2007-02-01" & mydata$Date<="2007-02-02",]

mydata <- within(mydata, { timestamp=format(as.POSIXct(paste(Date, Time)), "%Y-%m-%d %H:%M:%S")})
mydata$timestamp <- strptime(mydata$timestamp, format = "%Y-%m-%d %H:%M:%S")

png("plot4.png", width=480, height=480)  #start png image

par(mfrow=c(2,2))

#top left plot
plot(mydata$Global_active_power, xaxt='n', xlab = "", ylab = "Global Active Power (kilowatts)", type='l')
axis(1, at=c(1,1440, 2880), labels= c("Thu", "Fri", "Sat"))

#top right plot
plot(mydata$Voltage, type='l', xlab = "datetime", ylab = "Voltage", xaxt='n')
axis(1, at=c(1,1440, 2880), labels= c("Thu", "Fri", "Sat"))

#bottom left plot
plot(mydata$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", xaxt='n')
points(mydata$Sub_metering_2, col="red", type='l')
points(mydata$Sub_metering_3, col="blue", type='l')
legend("topright", lty=c(1,1), col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
axis(1, at=c(1,1440, 2880), labels= c("Thu", "Fri", "Sat"))

#bottom right plot
plot(mydata$Global_reactive_power, type='l', xaxt="n", xlab="datetime", ylab="Global_Reactive_power")
axis(1, at=c(1,1440, 2880), labels= c("Thu", "Fri", "Sat"))

dev.off()  #turns off png device