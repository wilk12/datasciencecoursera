temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
mydata <- read.csv(unz(temp,"household_power_consumption.txt"), sep=";", stringsAsFactors = FALSE)
unlink(temp)

#create subset with only the dates that are needed(2007-02-01 to 2007-02-02)
mydata$Date <- as.Date(mydata$Date, format = "%d/%m/%Y")
mydata <- mydata[mydata$Date>="2007-02-01" & mydata$Date<="2007-02-02",]

#create a column named timestamp that aggregates date and time columns into usable format
mydata <- within(mydata, { timestamp=format(as.POSIXct(paste(Date, Time)), "%Y-%m-%d %H:%M:%S")})
mydata$timestamp <- strptime(mydata$timestamp, format = "%Y-%m-%d %H:%M:%S")

png("plot3.png", width=480, height=480)  #start png image

plot(mydata$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", xaxt='n')
points(mydata$Sub_metering_2, col="red", type='l')
points(mydata$Sub_metering_3, col="blue", type='l')
legend("topright", lty=c(1,1), col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
axis(1, at=c(1,1440, 2880), labels= c("Thu", "Fri", "Sat"))

dev.off()  #turn off png device