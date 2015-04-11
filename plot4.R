setwd("") # set working directory to folder with data text file
g<-read.table("household_power_consumption.txt", header=TRUE, na.strings ="?", stringsAsFactors = FALSE, sep =";")
g$date2<- as.Date(g$Date,"%d/%m/%Y")
h<-g[g[,10] %in% as.Date(c("2007-02-01","2007-02-02")),]
h$datetime<- paste(h$date2,h$Time)
h$datetime<- as.POSIXct(strptime(h$datetime, "%Y-%m-%d %H:%M:%S"))
par(cex.axis=.75, cex.lab=.75, cex.main=.9, font =1)
png("out/plot4.png"
, width     = 3, height    = 3
, units     = "in", res       = 160, pointsize = 6
)

par(mfrow = c(2,2))
with(h, {
	 plot(datetime,Global_active_power, type ="l", xlab = NA, ylab ="Global Active Power (kilowatts)")
	 plot(datetime,Voltage, type ="l")
	 plot(datetime,Sub_metering_1, type ="l", xlab =NA , ylab= "Energy sub metering")
		lines(datetime,Sub_metering_2, type ="l", col = "red")
		lines(datetime,Sub_metering_3, type= "l", col = "blue")
		legend(
			"topright", lty=1, bty = "n", col=c("black","red","blue")
			, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex =.6)
	 plot(datetime,Global_reactive_power, type ="l")
})

dev.off()