library(dplyr)
library(data.table)

setwd("/Users/maureen/DataScience/ExploratoryDataAnalysis/week1_assignment")

# read in the data
infile <- "household_power_consumption.txt"
data <- fread(infile,sep=";",na.strings="?")
tdata <- tbl_df(data)

# convert the class of the Date column from character to Date
tdata$Date <- as.Date(tdata$Date, "%d/%m/%Y")

# create a combined data/time variable of the class POSIXlt / POSIXt
times <- strptime(paste(tdata$Date,tdata$Time,sep=" "), format="%Y-%m-%d %H:%M:%S")

# subset the data and the data/time variable to the requested time period
tdata_sel <- subset(tdata, times < "2007-02-03" & times > "2007-02-01")
times_sel <- subset(times, times < "2007-02-03" & times > "2007-02-01")

# print an error message if there are any missing values in the data subset
if (sum(is.na(tdata_sel) != 0)) {
   print("missing values in selected time period")
}

# create the fourth plot

png("plot4.png",width=480,height=480)

par(mfrow = c(2,2))

# top left
plot(times_sel,tdata_sel$Global_active_power,type="l",ylab="Global Active Power",xlab="")

# bottom left
plot(times_sel,tdata_sel$Voltage,xlab="datetime",ylab="Voltage",type="l")

# top right
plot(times_sel,tdata_sel$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
lines(times_sel,tdata_sel$Sub_metering_1,type="l",col="black")
lines(times_sel,tdata_sel$Sub_metering_2,type="l",col="red")
lines(times_sel,tdata_sel$Sub_metering_3,type="l",col="blue")
legtxt <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend("topright",legtxt,col= c("black","red","blue"),lty=1,box.lwd=0)

# bottom right
plot(times_sel,tdata_sel$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")

dev.off()
