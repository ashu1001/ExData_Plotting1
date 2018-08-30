
##### Downloading the Data
if (!file.exists("getPlotData.zip")){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL,"getPlotData.zip", method="curl")
}  
if (!file.exists("exdata_data_household_power_consumption")) { 
  unzip("getPlotData.zip") 
}


#### Reading Plot Data and subsetting based on the date
plotData <- read.table("./household_power_consumption.txt",header = TRUE,sep = ";")
plotData$Date <- as.Date(plotData$Date,format = "%d/%m/%Y")
plotData.new <- subset(plotData,Date == "2007-02-01" | Date == "2007-02-02")

#### Converting Active power to kilowatts
plotData.new$Global_active_power = as.numeric(plotData.new$Global_active_power)
powerKW <- sapply(plotData.new$Global_active_power,function(x){x/1000})

#### Constructing the plot and converting into png file
hist(powerKW,col = "red",xlab = "Global Active Power(kilowatts)",main = "Global Active Power")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()