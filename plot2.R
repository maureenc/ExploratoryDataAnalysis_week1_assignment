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

# create the second plot

png("plot2.png",width=480,height=480)

plot(times_sel,tdata_sel$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")

dev.off()

