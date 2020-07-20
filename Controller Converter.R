CombineData <- rbind(DataOne,Data2)
Data <-CombineData
Data$DATE<- paste(Data$DATE,Data$X.1)

Data<-Data[,c(1,5,6)]
library(xts)
Data$DATE<-strptime(Data$DATE,format="%a, %b %d, %Y %I:%M:%S %p")
xtsData <- as.xts(Data[c(2,3)], order.by = Data$DATE,frequency = NULL)
colnames(xtsData)<- c("CageTemp", "AmbientTemp")
ep <-endpoints(xtsData,"minutes")
byMin <- period.apply(xtsData,ep,mean)
write.csv(as.data.frame(byMin),"15121ControllerByMinutesPart2.csv", row.names = TRUE)
