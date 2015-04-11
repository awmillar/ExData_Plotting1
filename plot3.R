setwd("") # set working directory to folder with data text file
g<-read.table("household_power_consumption.txt", header=TRUE, na.strings ="?", stringsAsFactors = FALSE, sep =";")
g$date2<- as.Date(g$Date,"%d/%m/%Y")
h<-g[g[,10] %in% as.Date(c("2007-02-01","2007-02-02")),]
h$datetime<- paste(h$date2,h$Time)
h$datetime<- as.POSIXct(strptime(h$datetime, "%Y-%m-%d %H:%M:%S"))
par(cex.axis=.75, cex.lab=.75, cex.main=.9, font =1)
png("out/plot3.png" #code exports png files to subdirectory '/out'
, width     = 3, height    = 3
, units     = "in", res       = 160, pointsize = 5
)

with(h, plot(datetime,Sub_metering_1, type ="l", xlab =NA , ylab= "Energy sub metering"))
with(h, lines(datetime,Sub_metering_2, type ="l", col = "red"))
with(h, lines(datetime,Sub_metering_3, type= "l", col = "blue"))
legend(
	"topright", lty =1, col=c("black","red","blue")
	, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
	,cex=.75
	)

dev.off()