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

##Plot 3
plot(finalData$Sub_metering_1~finalData$Datetime, type="l",ylab="Energy sub metering", xlab="")
lines(finalData$Sub_metering_2~finalData$Datetime,col="red")
lines(finalData$Sub_metering_3~finalData$Datetime,col="blue")
legend("topright",lty=1,lwd=2,pt.cex=1,cex=.75,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


##Create .png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

options(warn=oldw)## turn back on warnings
rm(oldw)