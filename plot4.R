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
### Make the plot [4] 
##

png(file = "plot4.png", width = 480, height = 480, units = "px")

par(mfcol = c(2, 2))
with(data, {
  
  # Plot A
  plot(datetime,
       data$Global_active_power, 
       type = "l",
       xlab = "",
       ylab = "Global Active Power (kilowatts)")  
  
  
  # Plot B
  with(data, plot(datetime,
                  Sub_metering_1, 
                  type = "l",
                  xlab = "",
                  ylab = "Energy sub metering"))
  with(data, lines(datetime, Sub_metering_2, col = "red"))
  with(data, lines(datetime, Sub_metering_3, col = "blue"))
  legend("topright", col = c("black", "red", "blue"), 
         legend = names(data[,7:9]), lty=c(1,1,1))
  
  
  # Plot C
  plot(datetime,
       data$Voltage, 
       type = "l",
       ylab = "Voltage")  
  
  
  # Plot D
  plot(datetime,
       data$Global_reactive_power, 
       type = "l",
       ylab = "Global_reactive_power")
})

dev.off()