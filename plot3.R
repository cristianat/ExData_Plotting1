## script for reading data and creating plot#.png file

# downloading and unzipping data only if we didn't already (maybe manually)
if(!file.exists("./data/household_power_consumption.txt")){
        dir.create("./data")
        fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "./data/household_power_consumption.zip", 
                      method = "curl")
        unzip("./data/household_power_consumption.zip", exdir="./data")
}

# reading the data
data<-read.table("./data/household_power_consumption.txt",header=TRUE,sep=";",na.strings="?",
                 colClasses=c("character","character","numeric","numeric","numeric","numeric",
                              "numeric","numeric","numeric"), nrows = 2075259)

# subsetting the data
data_sel<-data[data$Date == "1/2/2007" | data$Date ==  "2/2/2007",]

# making plot3
time<-strptime(paste(data_sel$Date, data_sel$Time), format = "%d/%m/%Y %H:%M:%S")
png(filename="./plot3.png",width=480,height=480,units="px")
plot(time,data_sel$Sub_metering_1,ylab="Energy sub metering",xlab="",type="n")
lines(time, data_sel$Sub_metering_1)
lines(time, data_sel$Sub_metering_2, col ="red")
lines(time, data_sel$Sub_metering_3, col ="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lwd=1)
dev.off()