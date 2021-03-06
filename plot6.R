
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

## Q6
## Compare emissions from motor vehicle sources in Baltimore City with 
## emissions from motor vehicle sources in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). 
## Which city has seen greater changes over time in motor vehicle emissions
BaltimoreVehicleByYear <- aggregate(Emissions ~ year, 
                                    subset(SCC_PM25, fips == "24510" & type=="ON-ROAD"), 
                                    sum)
BaltimoreVehicleByYear$CityCounty <- "Baltimore City"

LosAngelesVehicleByYear <- aggregate(Emissions ~ year, 
                                     subset(SCC_PM25, fips == "06037" & type=="ON-ROAD"), 
                                     sum)
LosAngelesVehicleByYear$CityCounty <- "Los Angeles County"

MergedBLA <- rbind(BaltimoreVehicleByYear,LosAngelesVehicleByYear)

png(filename = "plot6.png", width = 480, height = 480, units = "px")

BLAPlot <- ggplot(MergedBLA,
                 aes(factor(year),
                 Emissions),
                 fill = CityCounty) +
     geom_bar(aes(fill=year), stat="identity",fill="grey",width=0.75) +
     facet_grid(scales="free", space="free", .~CityCounty) +
     labs(x="Years: 1999 - 2008", y=expression("Total PM"[2.5]*" Emission")) + 
     labs(title=expression("Motor Vehicle Source Emission in Baltimore vs. Los Angeles County: 1999-2008"))

print(BLAPlot)

dev.off()