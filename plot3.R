##### Downloading the Data
if (!file.exists("getPlotData.zip")){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL,"getPlotData.zip", method="curl")
}  
if (!file.exists("exdata_data_household_power_consumption")) { 
  unzip("getPlotData.zip") 
}


#### Reading Plot Data and subsetting based on the date
plotData <- read.table("./household_power_consumption.txt",header = TRUE,sep = ";",na.string="?")
plotData$Date <- as.Date(plotData$Date,format="%d/%m/%Y")
plotData.new <- subset(plotData,Date == "2007-02-01" | Date == "2007-02-02")
plotData.new$DateTime <- as.POSIXct(strftime(paste(plotData.new$Date, plotData.new$Time, sep=" ")))

startDay <- as.POSIXct(strftime("2007-02-01 00:00:00"))
endDay <- as.POSIXct(strftime("2007-02-03 00:00:00"))

plot(plotData.new$DateTime, plotData.new$Sub_metering_1, type="l",xlim = c(startDay,endDay),xlab="", ylab="Energy sub metering")
lines(plotData.new$DateTime,plotData.new$Sub_metering_2,col = "red")
lines(plotData.new$DateTime,plotData.new$Sub_metering_3,col = "blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="l",col=c("black","red","blue"),lwd=2,cex=0.7)

dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()



