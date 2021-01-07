###########
# Labour Markets of Resource Towns
# Author: Jiayi Liu
# Created Date: Jan 2018
###########
library(plyr)
library(dplyr)
# This r file generates the prices index using grades of reserve and production
rm(list = ls())

metal.price <- read.csv("P:/Liu_5114/metal-price-WB-2-2.csv")

metal.price$convert.10.02 <- metal.price[, 95]/metal.price[, 199] # price year 2010/ year 2002
metal.price$real02.1979 <- metal.price[,498]*metal.price$convert.10.02 # example

str.price1 <- paste0("metal.price$real02.", 1979+5*seq(0,7,1))
str.price2 <- paste0("metal.price[,", 498-13*5*seq(0,7,1), "]*metal.price$convert.10.02")
str.price <- paste(str.price1, str.price2, sep = " <- ")
eval(parse(text = str.price))




################# As my project only use 1980 mine grades, so I didn't add the grade data of mines in 2011 and 2016 so just add longer metal price here)
for (j in seq(1979, 2004, 5)) {
  import <- paste0("df.mine <- read.csv('" ,"P:/Liu_5114/result/handbook-data/", j+1, "-trimmed.csv')")
  eval(parse(text = import))
  grade <- as.matrix(df.mine[c(5:16)]) #replace NAs with 0's
  for (i in 1:nrow(grade)){
    for (k in 1:ncol(grade)){
      if (is.na(grade[i,k])){
        grade[i,k] <- 0
      }
    }
  }
  df.mine2 <- df.mine[c(-5:-16)]
  df.mine2 <- cbind(df.mine2, data.frame(grade))
  # Record the source of grade data of each observationn
  grade.source <- as.character(df.mine2$X_merge)
  for (i in 1:nrow(df.mine2)) {
    if (grade.source[i]== "matched (3)") {
      grade.source[i] <- "res_prod"
    } else if (grade.source[i]== "master only (1)") {
      grade.source[i] <- "res"
    } else {
      grade.source[i] <- "prod"
    }
  }
  df.mine2$grade.source <- grade.source
  # Create price index using firstly reserve's grade data and then production's grade data
  ## Reserve
  str1 <- paste0("mine.price.res.",seq(j ,2014, by = 5))
  str2 <- paste0("df.mine2$gold_grade_weighed*metal.price[2,", 747 + c(((j - 1979)/5):7) , "]")
  str3 <- paste0("df.mine2$silver_grade_weighed*metal.price[12,", 747 + c(((j - 1979)/5):7) , "]")
  str4 <- paste0("df.mine2$zinc_grade_weighed*metal.price[4,", 747 + c(((j - 1979)/5):7) , "]*9.072")
  str5 <- paste0("df.mine2$copper_grade_weighed*metal.price[8,", 747 + c(((j - 1979)/5):7), "]*0.009072")
  str6 <- paste0("df.mine2$lead_grade_weighed*metal.price[6,", 747 + c(((j - 1979)/5):7), "]*0.009072")
  str7 <- paste0("df.mine2$nickel_grade_weighed*metal.price[10,", 747 + c(((j - 1979)/5):7), "]*0.009072")
  if (is.null(df.mine2$nickel_grade_weighed)==TRUE) {
    str.res <- paste0(str1," <- ", str2," + ", str3," + ", str4," + ", str5," + ", str6)
    eval(parse(text = str.res))
  } else {
    str.res <- paste0(str1," <- ", str2," + ", str3," + ", str4," + ", str5," + ", str6," + ", str7)
    eval(parse(text = str.res))
  }
  
  ### Get the metal with the highest portion in reserve price
  str8 <- paste0("res.gold.price.", seq(j ,2014, by = 5))
  str9 <- paste0("res.silver.price.", seq(j ,2014, by = 5))
  str10 <- paste0("res.zinc.price.", seq(j ,2014, by = 5))
  str11 <- paste0("res.copper.price.", seq(j ,2014, by = 5))
  str12 <- paste0("res.lead.price.", seq(j ,2014, by = 5))
  str13 <- paste0("res.nickel.price.", seq(j ,2014, by = 5))
  str.res.gold <- paste0(str8, " <- ", str2)
  eval(parse(text = str.res.gold))
  str.res.silver <- paste0(str9, " <- ", str3)
  eval(parse(text = str.res.silver))
  str.res.zinc <- paste0(str10, " <- ", str4)
  eval(parse(text = str.res.zinc))
  str.res.copper <- paste0(str11, " <- ", str5)
  eval(parse(text = str.res.copper))
  str.res.lead <- paste0(str12, " <- ", str6)
  eval(parse(text = str.res.lead))
  str.res.nickel <- paste0(str13, " <- ", str7)
  eval(parse(text = str.res.nickel))

  if (is.null(df.mine2$nickel_grade_combine)==TRUE) {
    str14 <- paste0("res.price.", seq(j ,2014, by = 5), " <- ", "data.frame(res.gold.price.", seq(j ,2014, by = 5), ", res.silver.price.", seq(j ,2014, by = 5),", res.zinc.price.", seq(j ,2014, by = 5), ", res.copper.price.", seq(j ,2014, by = 5), ", res.lead.price.", seq(j ,2014, by = 5),")")
    eval(parse(text = str14))
  } else {
    str14 <- paste0("res.price.", seq(j ,2014, by = 5), " <- ", "data.frame(res.gold.price.", seq(j ,2014, by = 5), ", res.silver.price.", seq(j ,2014, by = 5),", res.zinc.price.", seq(j ,2014, by = 5), ", res.copper.price.", seq(j ,2014, by = 5), ", res.lead.price.", seq(j ,2014, by = 5),", res.nickel.price.", seq(j ,2014, by = 5),")")
    eval(parse(text = str14))
  }
  str15 <- paste0("res.hiratio1.", seq(j ,2014, by = 5), " <- ", "max.col(res.price.", seq(j ,2014, by = 5), ", 'first')")
  eval(parse(text = str15))
  str16 <- paste0("res.hiratio2.", seq(j ,2014, by = 5), " <- ", "max.col(res.price.", seq(j ,2014, by = 5), ", 'last')")
  eval(parse(text = str16))
  
  ## Prod
  str1 <- paste0("mine.price.prod.",seq(j ,2014, by = 5))
  str2 <- paste0("df.mine2$gold_grade_combine*metal.price[2,", 747 + c(((j - 1979)/5):7) , "]")
  str3 <- paste0("df.mine2$silver_grade_combine*metal.price[12,", 747 + c(((j - 1979)/5):7) , "]")
  str4 <- paste0("df.mine2$zinc_grade_combine*metal.price[4,", 747 + c(((j - 1979)/5):7) , "]*9.072")
  str5 <- paste0("df.mine2$copper_grade_combine*metal.price[8,", 747 + c(((j - 1979)/5):7), "]*0.009072")
  str6 <- paste0("df.mine2$lead_grade_combine*metal.price[6,", 747 + c(((j - 1979)/5):7), "]*0.009072")
  str7 <- paste0("df.mine2$nickel_grade_combine*metal.price[10,", 747 + c(((j - 1979)/5):7), "]*0.009072")
  
  if (is.null(df.mine2$nickel_grade_combine)==TRUE) {
    str.prod <- paste0(str1," <- ", str2," + ", str3," + ", str4," + ", str5," + ", str6)
    eval(parse(text = str.prod))
  } else {
    str.prod <- paste0(str1," <- ", str2," + ", str3," + ", str4," + ", str5," + ", str6," + ", str7)
    eval(parse(text = str.prod))
  }
  ### Get the metal with the highest portion in production price
  str8 <- paste0("prod.gold.price.", seq(j ,2014, by = 5))
  str9 <- paste0("prod.silver.price.", seq(j ,2014, by = 5))
  str10 <- paste0("prod.zinc.price.", seq(j ,2014, by = 5))
  str11 <- paste0("prod.copper.price.", seq(j ,2014, by = 5))
  str12 <- paste0("prod.lead.price.", seq(j ,2014, by = 5))
  str13 <- paste0("prod.nickel.price.", seq(j ,2014, by = 5))
  str.prod.gold <- paste0(str8, " <- ", str2)
  eval(parse(text = str.prod.gold))
  str.prod.silver <- paste0(str9, " <- ", str3)
  eval(parse(text = str.prod.silver))
  str.prod.zinc <- paste0(str10, " <- ", str4)
  eval(parse(text = str.prod.zinc))
  str.prod.copper <- paste0(str11, " <- ", str5)
  eval(parse(text = str.prod.copper))
  str.prod.lead <- paste0(str12, " <- ", str6)
  eval(parse(text = str.prod.lead))
  str.prod.nickel <- paste0(str13, " <- ", str7)
  eval(parse(text = str.prod.nickel))
  
  if (is.null(df.mine2$nickel_grade_combine)==TRUE) {
    str14 <- paste0("prod.price.", seq(j ,2014, by = 5), " <- ", "data.frame(prod.gold.price.", seq(j ,2014, by = 5), ", prod.silver.price.", seq(j ,2014, by = 5),", prod.zinc.price.", seq(j ,2014, by = 5), ", prod.copper.price.", seq(j ,2014, by = 5), ", prod.lead.price.", seq(j ,2014, by = 5),")")
    eval(parse(text = str14))
  } else {
    str14 <- paste0("prod.price.", seq(j ,2014, by = 5), " <- ", "data.frame(prod.gold.price.", seq(j ,2014, by = 5), ", prod.silver.price.", seq(j ,2014, by = 5),", prod.zinc.price.", seq(j ,2014, by = 5), ", prod.copper.price.", seq(j ,2014, by = 5), ", prod.lead.price.", seq(j ,2014, by = 5),", prod.nickel.price.", seq(j ,2014, by = 5),")")
    eval(parse(text = str14))
  }
  str15 <- paste0("prod.hiratio1.", seq(j ,2014, by = 5), " <- ", "max.col(prod.price.", seq(j ,2014, by = 5), ", 'first')")
  eval(parse(text = str15))
  str16 <- paste0("prod.hiratio2.", seq(j ,2014, by = 5), " <- ", "max.col(prod.price.", seq(j ,2014, by = 5), ", 'last')")
  eval(parse(text = str16))
  
  # Combine both reserve and prod together 
  str1 <- paste0("mine.price.", seq(j,2014, by = 5), "[i,1]")
  str2 <- paste0("mine.price.", seq(j,2014, by = 5), "[i,2]")
  str3 <- paste0("mine.price.", seq(j,2014, by = 5), "[i,3]")
  str4 <- paste0("mine.price.res.", seq(j,2014, by = 5), "[i]")
  str5 <- paste0("res.hiratio1.", seq(j,2014, by = 5), "[i]")
  str6 <- paste0("res.hiratio2.", seq(j,2014, by = 5), "[i]")
  str7 <- paste0("mine.price.prod.", seq(j,2014, by = 5), "[i]")
  str8 <- paste0("prod.hiratio1.", seq(j,2014, by = 5), "[i]")
  str9 <- paste0("prod.hiratio2.", seq(j,2014, by = 5), "[i]")
  str.res1 <- paste(str1, str4, sep = " <- ")
  str.res2 <- paste(str2, str5, sep = " <- ")
  str.res3 <- paste(str3, str6, sep = " <- ")
  str.prod1 <- paste(str1, str7, sep = " <- ")
  str.prod2 <- paste(str2, str8, sep = " <- ")
  str.prod3 <- paste(str3, str9, sep = " <- ")
  str.mine.price <- paste0("mine.price.", seq(j,2014, by = 5), " <- matrix(NA,nrow = nrow(df.mine2), ncol = 3)")
  eval(parse(text = str.mine.price))
  for ( i in 1:nrow(df.mine2)){
    if (grade.source[i] =="prod" ) {
      eval(parse(text = str.prod1))
      eval(parse(text = str.prod2))
      eval(parse(text = str.prod3))
    } else {
      eval(parse(text = str.res1))
      eval(parse(text = str.res2))
      eval(parse(text = str.res3))
    }
  }
  str.price.res <- paste0("df.mine2$mine.price.res.", seq(j,2014, by = 5), " <- mine.price.res.", seq(j,2014, by = 5))
  eval(parse(text = str.price.res))
  
  str.price.prod <- paste0("df.mine2$mine.price.prod.", seq(j,2014, by = 5), " <- mine.price.prod.", seq(j,2014, by = 5))
  eval(parse(text = str.price.prod))
  
  str.combine <- paste0("df.mine2$mine.price.", seq(j,2014, by = 5), " <- mine.price.", seq(j,2014, by = 5), "[,1]")
  eval(parse(text = str.combine))
  
  str.log <- paste0("df.mine2$ln.mine.price.", seq(j,2014, by = 5), " <- log(df.mine2$mine.price.", seq(j,2014, by = 5), ")")
  eval(parse(text = str.log))
  
  str.hiratio1 <- paste0("df.mine2$hiratio1.", seq(j,2014, by = 5), " <- mine.price.", seq(j,2014, by = 5), "[,2]")
  eval(parse(text = str.hiratio1))
  
  str.hiratio2 <- paste0("df.mine2$hiratio2.", seq(j,2014, by = 5), " <- mine.price.", seq(j,2014, by = 5), "[,3]")
  eval(parse(text = str.hiratio2))
  
  if (j < 2014) {
    str.delta <- paste0("df.mine2$d.ln.mine.price.", seq(j + 5,2014, by = 5), " <- df.mine2$ln.mine.price.", seq(j + 5,2014, by = 5), " - df.mine2$ln.mine.price.", seq(j,2009, by = 5))
    eval(parse(text = str.delta))
  } else {
    df.mine2$d.ln.mine.price.2014.null <- NA
  }
  
  # save
  sav <- paste0("write.csv(df.mine2,'P:/Liu_5114/result/handbook-data/", j+1, "-trimmed-price-real2002.csv')")
  eval(parse(text = sav))
}



