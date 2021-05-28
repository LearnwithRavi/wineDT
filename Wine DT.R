# Wine Data working
library(dplyr)
library(ggplot2)
library(mlr)
library(partykit)
library(rpart)
library(car)

wine <- read.csv(file.choose(),header = T,sep = ",")
str(wine)
# here our target var will be quality col
head(wine)
sum(is.na(wine))
# it is already prepared for analysis
# lets prepare it for DT
# One Hot Encoding -  of the dependent var i.e our target variable
desc_quality <-  ifelse(wine$quality>6,"Y","N")
wine <- data.frame(wine,desc_quality)

# lets now remove the quality col that was numeric
wine <- wine[,-12]
table(wine$desc_quality)
# so the data is prepared - it is made into classification prob by the OHE that we did
# with the quality col

# classification Tree ####
desc_model <- rpart(desc_quality ~., data = wine, method = "class",
                    control = rpart.control(minsplit = 60,minbucket = 30,maxdepth = 4))
plot(as.party(desc_model))

# this DT is not looking nice and yes it is true as well because a good DT is that 
# which has less depth i.e less nodes , once you will read the theory you will
# know the terms

