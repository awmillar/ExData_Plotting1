setwd("") # set working directory to folder with data text file
g<-read.table("household_power_consumption.txt", header=TRUE, na.strings ="?", stringsAsFactors = FALSE, sep =";")
g$date2<- as.Date(g$Date,"%d/%m/%Y")
h<-g[g[,10] %in% as.Date(c("2007-02-01","2007-02-02")),]
h$datetime<- paste(h$date2,h$Time)
h$datetime<- as.POSIXct(strptime(h$datetime, "%Y-%m-%d %H:%M:%S"))
par(cex.axis=.75, cex.lab=.75, cex.main=.9, font =1)
png("out/plot2.png"
, width     = 3, height    = 3
, units     = "in", res       = 160, pointsize = 5
)
with(h, plot(datetime,Global_active_power, type ="l", xlab = NA
	, ylab ="Global Active Power (kilowatts)")
	)
dev.off()