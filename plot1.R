#extractdata
library(data.table)
findRows<-fread("household_power_consumption.txt", header = TRUE, select = 1)
all<-(which(findRows$Date %in% c("1/2/2007", "2/2/2007")) )
skipLines<- min(all)
keepRows<- length(all)
data<- fread("household_power_consumption.txt", skip = (skipLines) , nrows = keepRows, header = TRUE)
rm(findRows)
dataNames<- names(fread("household_power_consumption.txt", nrow = 1))
setnames(data, dataNames)
data<-as.data.frame(data)
data <- within(data, datatime <- paste(data$Date, data$Time, sep = ' '))
data$datatime<-strptime(data$datatime, "%d/%m/%Y %H:%M:%S")

#plot1
png(filename = "plot1.png", width = 480, height = 480)
hist(data$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)",cex.axis=0.9)
dev.off()