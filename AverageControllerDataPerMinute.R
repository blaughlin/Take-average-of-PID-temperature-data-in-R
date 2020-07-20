# Change directory to where controller data file is; use shortcut: control shift H
library(lubridate)
library(xts)


path <- file.choose()
cage<- read.table(path,skip=1) #load file
time <- paste(cage$V1,cage$V2,cage$V3,cage$V4,cage$V5,cage$V6) #subselect time
time <- strptime(time, format ="%a, %b %d, %Y %I:%M:%S %p") #convert to time class
cageTemp <- cage$V8 #subselect cage temperature
ambientTemp <- cage$V9 #subselect ambient temperature
setPoint <- cage$V10 #subselect set point temperature
cageData <- data.frame(time,cageTemp,ambientTemp, setPoint) #create dataframe with time, cage and ambient temp
cageData$time<- force_tz(cageData$time, tzone = "UTC") #standarize time zone to DSI
cageData <- as.xts(cageData[c(2,3,4)], order.by = cageData$time, frequency = NULL) #creates xts object
cageData <- period.apply(cageData,endpoints(cageData,"minutes"),mean) #creates mean of data per min
savefilename = "CageData18022.csv" #Change name to rat ID
write.csv(cageData, savefilename, row.names = FALSE)
