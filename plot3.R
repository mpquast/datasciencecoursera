# In order to plot the wished graphics, we first have to subset the data set.
# Since the data is ordered, we have to find the first line that contains the first date we want and, then,
# how many lines contain such dates. That is made reading just the first column and checking which rows
# contain the wished dates. Then we read from the date set just the wished lines. Finally, we plot the graphic.

## reads just the first column (containing the dates)
table.dates <- read.table("household_power_consumption.txt", colClasses = c("character", rep("NULL", 8)), 
	sep = ";", header = T)

##search the dates looking for the ones we want, and keep the numbers of their lines in the "rows" vector
rows = NULL
j = 1
for (i in 1: nrow(table.dates)){
	if (table.dates$Date[i] == "1/2/2007" || table.dates$Date[i] == "2/2/2007"){
		rows[j] <- i
		j = j+1
	}
}

##reads the lines that contain the dates we want
dataset <- read.table("household_power_consumption.txt", sep = ";", header = F, skip = rows[1], nrow=length(rows))

##gets the columns names
head.table <- read.table("household_power_consumption.txt", sep = ";", header = T, nrow=1)
colnames(dataset) <- colnames(head.table)

##change type of Date and Time, and put together under "Date" 
dataset$Date <- strptime(paste(dataset$Date,dataset$Time), "%d/%m/%Y %H:%M:%S")


## Now, we plot the graphic.
### opens teh PNG device
png("plot3.png")

### since we have 3 variables to plot against Date, we first create the plot (using the plot function with type = 'n'),
### the we add lines for each variable

plot(dataset$Date, dataset$Sub_metering_1, type = 'n', xlab = "", 
	ylab = "Energy sub metering")
lines(dataset$Date, dataset$Sub_metering_1)
lines(dataset$Date, dataset$Sub_metering_2, col='red')
lines(dataset$Date, dataset$Sub_metering_3, col='blue')

### adds legend
legend("topright", lwd = 1, col = c("black", "red", "blue"), 
	legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

### closes device
dev.off()





	

