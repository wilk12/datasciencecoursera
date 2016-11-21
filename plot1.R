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

#make Globabl_active_power data numeric
mydata$Global_active_power <- as.numeric(mydata$Global_active_power)

png("plot1.png", width=480, height=480)  #start png image

hist(mydata$Global_active_power, breaks=16,col = "red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")

dev.off()  # turn off png device