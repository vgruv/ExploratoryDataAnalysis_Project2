
## read the data files
## summarySCC_PM25.rds file contains a data frame with all of the PM2.5 emissions data 
## for 1999, 2002, 2005, and 2008.
## 𝚏𝚒𝚙𝚜: A five-digit number (represented as a string) indicating the U.S. county
## 𝚂𝙲𝙲: The name of the source as indicated by a digit string (see source code classification table)
## 𝙿𝚘𝚕𝚕𝚞𝚝𝚊𝚗𝚝: A string indicating the pollutant
## 𝙴𝚖𝚒𝚜𝚜𝚒𝚘𝚗𝚜: Amount of PM2.5 emitted, in tons
## 𝚝𝚢𝚙𝚎: The type of source (point, non-point, on-road, or non-road)
## 𝚢𝚎𝚊𝚛: The year of emissions recorded
if(!exists("SCC_PM25")){
     SCC_PM25 <- readRDS("./summarySCC_PM25.rds")
}

## This table provides a mapping from the SCC digit strings in the Emissions table 
## to the actual name of the PM2.5 source.
if(!exists("SCC")){
     SCC <- readRDS("./Source_Classification_Code.rds")
}

## Q2
## Have total emissions from PM2.5 decreased in the Baltimore City, 
## Maryland (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999
## to 2008? Use the base plotting system to make a plot answering this question.
BaltimoreDataByYear <- aggregate(Emissions ~ year, subset(SCC_PM25, fips == "24510"), sum)
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(BaltimoreDataByYear$year, 
     BaltimoreDataByYear$Emissions, 
     type = "o", 
     main = "Total PM2.5 Emission in Baltimore by year: 1999 - 2008",
     xlab = "Year", 
     ylab = "Total PM2.5 Emission in Baltimore",
     pch = 19,
     lwd = 3,
     col = "blue")
dev.off()
