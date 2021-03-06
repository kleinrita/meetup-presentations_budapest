rm(list=ls())

setwd("C:/Data Science/R-Ladies Budapest/2017.03.23")
#dir("C:/Data Science/R-Ladies Budapest/2017.03.23")



#install.packages("readxl")
library(readxl)
data <- read_excel("KerdoivEredmenyek.xlsx")
#data <- read.csv("KerdoivEredmenyek.csv")

#data
#str(data)
#class(data)

#ncol(data)
#nrow(data)
#length(data)

#class(length(data))



#R-objects:
#Vectors
#Lists
#Matrices
#Arrays
#Factors
#Data Frames

#data types of vector
#numeric
#integer
#complex
#logical 
#character



#colnames(data)
#rownames(data)
#names(data)

#class(names(data))

#�rtelmezz�k az oszlop neveket �s cser�lj�nk:
#ehhez kell egy karakter vektor
names <- names(data)
names[16:17] <- c("g�pitanul�s", "fel�gyelttanul�s")
names(data) <- names



#v�lasszunk oszopot, dobjuk ki Julia-t:

#[] megold�s 1
R <- data[,1]
#vagy
R <- data$R
data320 <- data[,3:20]
filteredData <- cbind(R,data320)
#rbind

#[] megold�s 2
filteredData <- data[,c(1,3:20)]

#[] megold�s 3
filteredData <- data[,-2]

#subset megold�s
filteredData <- subset(data, select=-Julia)

#dplyr megold�s
#install.packages("dplyr")
library(dplyr)
#??dplyr
filteredData <- select(data, -Julia)



#v�lasszunk sort, dobjuk ki azokat akik k�pesek voltak NA-kat produk�lni:
#complete.cases(data)
#class(complete.cases(data))

#[] megold�s
filteredDataWithoutNA<- filteredData[complete.cases(filteredData), ]

#subset megold�s
filteredDataWithoutNA <- subset(filteredData, complete.cases(filteredData))

#dplyr megold�s
filteredDataWithoutNA <- filter(filteredData, complete.cases(filteredData))

#direkt megold�s
filteredDataWithoutNA <- na.omit(filteredData)



boxplot(filteredDataWithoutNA$boxplot)
boxplot(filteredDataWithoutNA$R, filteredDataWithoutNA$ggplot2, filteredDataWithoutNA$shiny)

