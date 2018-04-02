
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

## Q4
## Across the United States, how have emissions from coal combustion-related sources 
## changed from 1999–2008?
library(ggplot2)

coalMatch  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
coalSCC <- SCC[coalMatch, ]
## dim(coalSCC)
combMatch  <- grepl("comb", SCC$Short.Name, ignore.case=TRUE)
combSCC <- SCC[combMatch, ]
## dim(combSCC)

CoalCombSCC <- SCC[(coalMatch & combMatch), "SCC"]
CoalCombSCC_PM25 <- SCC_PM25[SCC_PM25$SCC %in% CoalCombSCC,]

TotalCoalCombByYear <- aggregate(Emissions ~ year, CoalCombSCC_PM25, sum)

png(filename = "plot4.png", width = 480, height = 480, units = "px")

CoalCombPlot <- ggplot(TotalCoalCombByYear,
                       aes(factor(year),
                       Emissions)) +
     geom_bar(stat="identity",fill="grey",width=0.75) +
     guides(fill=FALSE) +
     labs(x="Years: 1999 - 2008", y=expression("Total PM"[2.5]*" Emission")) + 
     labs(title=expression("Coal Combustion Source Emission Across US: 1999-2008"))

print(CoalCombPlot)

dev.off()

