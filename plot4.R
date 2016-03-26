##Check that the data.table library is installed, and if not, install it
if(!"data.table" %in% installed.packages())
{
  install.packages("data.table")
}

library(data.table) ## loading the data.table library to use fread

## turn off fread warnings
oldw<-getOption("warn")
options(warn=-1)

##read data
powerData<-fread("household_power_consumption.txt")

## changing Date column to date class
powerData$Date<-as.Date(powerData$Date,"%d/%m/%Y")


##subset data and remove full set
finalData<-subset(powerData,as.Date(powerData$Date,"%d/%m/%Y")>=as.Date("2007/02/01","%Y/%m/%d")&as.Date(powerData$Date,"%d/%m/%Y")<=as.Date("2007/02/02","%Y/%m/%d"))
rm(powerData)

##Creating Datetime column
datetime <- paste(as.Date(finalData$Date), finalData$Time)
finalData$Datetime <- as.POSIXct(datetime)

##Plot 4
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

with(finalData, {
  plot(Global_active_power~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  
  plot(Voltage~Datetime, type="l",
       ylab="Voltage", xlab="")
  
  plot(Sub_metering_1~Datetime, type="l",ylab="Energy sub metering", xlab="datetime")
      lines(Sub_metering_2~Datetime,col="red")
      lines(Sub_metering_3~Datetime,col="blue")
      legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", 
             legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(Global_reactive_power~Datetime, type="l", ylab="Global_reactive_power", xlab="datetime")})


##Create .png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

options(warn=oldw)## turn back on warnings
rm(oldw)
