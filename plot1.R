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

##Plot
hist(as.numeric(finalData$Global_active_power),col="red",xlab="Global Active Power(kilowatts)", ylab="Frequency",main="Global Active Power")


##Create .png file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

options(warn=oldw)## turn back on warnings
rm(oldw)