##
### Read just the needed subset of the data set
##

colnames <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
              "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", 
              "Sub_metering_3")

data <- read.table("./data/household_power_consumption.txt", 
                   header = TRUE, 
                   sep = ";",
                   col.names = colnames,
                   stringsAsFactors = FALSE,
                   na.strings = c("?"),
                   skip = grep("31/1/2007;23:58:00", 
                               readLines("./data/household_power_consumption.txt")),
                   nrows = 2880)

datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

##
### Make the plot [2] 
##

png(file = "plot2.png", width = 480, height = 480, units = "px")

plot(datetime,
     data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

dev.off()