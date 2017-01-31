
library(dplyr)

setwd('C:/Users/your_filepath_goes_here/TIL Datasets')

df <- read.csv('HCAHPSHospital.csv')
head(df)

#keep only one record per provider ID; specifically, the record that has the summary star rating
#also exclude those without a summary rating
df2 <- df[df$HCAHPS.Measure.ID=="H_STAR_RATING" & df$Patient.Survey.Star.Rating!="Not Available",]
head(df2)

#convert star rating to numeric and filter results to 4/5 star hospitals
df2$star_rating=as.numeric(as.character(df2$Patient.Survey.Star.Rating))
df3 <- df2[df2$star_rating>3,]
head(df3)

#randomly sample 200 facilities, 100 from each star level
df4 <- df3 %>% group_by(star_rating) %>% sample_n(size=100)
count(df4,star_rating)

#save final sample
write.csv(df4, "HC_SAMPLE_6.7.16.csv")


