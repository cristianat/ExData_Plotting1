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

# making plot2
time<-strptime(paste(data_sel$Date, data_sel$Time), format = "%d/%m/%Y %H:%M:%S")
png(filename="./plot2.png",width=480,height=480,units="px")
plot(time,data_sel$Global_active_power,ylab="Global Active Power (kilowatts)",xlab="",type="n")
lines(time, data_sel$Global_active_power)
dev.off()