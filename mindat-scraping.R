# Labour Maket of Resource Towns#
# Jiayi Liu #
# Nov 2017 #

# Scrape data from https://www.mindat.org to get GIS of mines#
library(rvest)
library(Rcrawler)
library(plyr)
library(dplyr)
library(readr)
library(stringr)

## prepare links for general and advance search 
metal.mine.80 <- read_csv("/Users/batta/Dropbox/phd4/monopsony/mining-r/mine-30th-unmatched1.csv")
metal.mine.80 <- metal.mine.80 %>% 
	select(PROVINCE, COMPANY, MINESITE, LOCATION)
test <- metal.mine.80 %>% 
	filter(MINESITE!="" | LOCATION !="")
province <- str_replace(test$PROVINCE,"\\b[[:space:]]+\\b", "+" )
location <- str_replace_all(test$LOCATION,"\\b[[:space:]]*,[[:space:]]*\\b", "+" )
location <- str_replace_all(location, "\\b[[:space:]]+\\b","+")
location <- str_replace_all(location, "-","+")
minesite <- str_replace_all(test$MINESITE, "\\b[[:space:]]+\\b", "+" )
minesite <- str_replace_all(minesite,"The\\+","")
site.location <- paste0(minesite,"+", location)
site.location <- str_replace_all(site.location, "^\\+","")
gensearch <- "https://www.mindat.org/search.php?search="
advsearch <- "https://www.mindat.org/lsearch.php?adv=1&loc="
gensearch.link <- paste0(gensearch, site.location,"+",province,"+","canada")# need to combine with mine locations
advsearch.link <- paste0(advsearch, location,"&tlr=Canada")

## Advance search
prov <- tolower(test$PROVINCE)
prov <- gsub("\\b([a-z])", "\\U\\1", prov, perl = TRUE)
prov <- gsub("Quebec", "Québec", prov)
prov <- gsub("Yukon Territory", "Yukon", prov)
loc <- str_replace_all(test$LOCATION, "\\b[[:space:]]+\\b"," ")
loc <- str_replace_all(loc, "d'or", "d'Or")
advsearch.num <- matrix(NA, length(advsearch.link))
advmine.gis <-  matrix(NA, length(advsearch.link))
advmine.gis2 <-  matrix(NA, length(advsearch.link))
mine.links <-  matrix(NA, length(advsearch.link))
mine.links.num <- matrix(NA, length(advsearch.link))
advsearch.not1 <- matrix(NA, length(advsearch.link))
picked.link <- matrix(NA, length(advsearch.link))
for (i in 1:length(advsearch.link)) {
	advsearch.result <- read_html(advsearch.link[i])
	advsearch.number <- advsearch.result %>% 
		html_node("p+ p") %>% 
		html_text()
	advsearch.not1[i] <- str_detect(advsearch.number, "Search returned:")
	if (is.na(advsearch.not1[i])==TRUE | advsearch.not1[i] == FALSE) { #Only one search result
		advsearch.num[i] <- 1
		advsearch.name <- advsearch.result %>% 
			html_node("h1") %>% 
			html_text()
		check.prov <- str_detect(advsearch.name, prov[i])
		check.table <- advsearch.result %>% 
			html_node("table")
		if (check.prov==TRUE & length(check.table)>0) {
			tmp <- advsearch.result %>% 
			html_node("table") %>% 
			html_table()
		advmine.gis[i] <- tmp[1,2]
		advmine.gis2[i] <- tmp[2,2]
		picked.link[i] <- advsearch.link[i]
		}
	} else { # Multiple search results
		advsearch.num[i] <- str_extract(advsearch.number, "\\d+") # 0 or >1
		if (advsearch.num[i] >1) { 
			links <- LinkExtractor(advsearch.link[i])
			links <- str_subset(links[[2]], "/loc-")
			maxmatch <- 0
			minloc <- 10
			for (j in 1:length(links)){
				advsearch.result2 <- read_html(links[j]) 
				advsearch.name <- advsearch.result2 %>% 
					html_node("h1") %>% 
					html_text()
				check.prov <- str_detect(advsearch.name, prov[i])
				check.table <- advsearch.result2 %>% 
					html_node("table")
				if (check.prov==FALSE | length(check.table) == 0 | html_text(check.table)==""){
					links[j] <- NA
				} else {
					firstword <- str_split(advsearch.name,",\\s*")[[1]]
					locc <- str_split(loc[i],",\\s*")[[1]][1]
					match <- str_detect(firstword, locc)
					match.num <- sum(match)
					first.match <- which(match==TRUE)[1]
					if (match.num > maxmatch & length(check.table) > 0) { 
						tmp <- advsearch.result2 %>% 
							html_node("table") %>% 
							html_table()
						advmine.gis[i] <- tmp[1,2]
						advmine.gis2[i] <- tmp[2,2]
						maxmatch <- match.num
						minloc <- first.match 
						picked.link[i] <- links[j]
					} else if (match.num == maxmatch & length(check.table) > 0 & !is.na(first.match) == TRUE & first.match < minloc){
						tmp <- advsearch.result2 %>% 
							html_node("table") %>% 
							html_table()
						advmine.gis[i] <- tmp[1,2]
						advmine.gis2[i] <- tmp[2,2]
						minloc <- first.match
						picked.link[i] <- links[j]
					}
				}
			}
			links <- str_subset(links, "/loc-")
			mine.links.num[i] <- length(links)
			mine.links[i] <- paste(links, collapse = " ")
		}
	}
}
advsearch2 <- data.frame(advsearch.link, advmine.gis, advmine.gis2 , advsearch.not1, advsearch.num, mine.links, mine.links.num, picked.link)
advsearch2$advsearch.num <- as.numeric(as.character(advsearch2$advsearch.num))

tt <- str_replace(advsearch2$advmine.gis2, "(~.*)", replacement = "")
tt[which(tt=="")] <- NA
advsearch2$advmine.gis3 <- tt
test <- metal.mine.80 %>% 
	select(PROVINCE, MINESITE, COMPANY, LOCATION) %>% 
	filter(is.na(LOCATION)==FALSE)
tmp <- cbind(test, advsearch2)
advsearch2.test <- tmp %>% 
	filter(is.na(advmine.gis3)==FALSE)
ttt <- str_split(advsearch2.test$advmine.gis3,",")
df <- data.frame(matrix(unlist(ttt), nrow=nrow(advsearch2.test), byrow=T),stringsAsFactors=FALSE)
colnames(df) <- c("LATITUDE", "LONGITUDE")
advsearch2.test <- cbind(advsearch2.test,df)
write_csv(advsearch2.test, "/Users/batta/Dropbox/phd4/monopsony/mining-r/advsearch-30-test.csv")
matchedCSD <- read_csv("/Users/batta/Dropbox/phd4/monopsony/mining-r/matched-map30-boundary06.csv")
matchedCSD.direct <- write_csv(match.mine.8081, "/Users/batta/Dropbox/phd4/monopsony/mining-r/mine-30th-matched1.csv")

matchedCSD <- matchedCSD %>% 
	select(PROVINCE, COMPANY, MINESITE, LOCATION, CSDUID, CSDNAME)
matchedCSD.direct <- matchedCSD.direct %>% 
	select(PROVINCE, COMPANY, MINESITE, LOCATION, sgcfull, csdname)
colnames(matchedCSD.direct) <- c("PROVINCE", "COMPANY", "MINESITE", "LOCATION", "CSDUID", "CSDNAME")

matchedCSD.full <- rbind(matchedCSD.direct, matchedCSD) #87 out of 104 matched with CSD
write_csv(matchedCSD.full, "/Users/batta/Dropbox/phd4/monopsony/mining-r/mine-30th-CSD.csv")

## The obs has no correct result returned
advsearch3 <- advsearch2 %>% 
	filter(is.na(advmine.gis)==TRUE & advsearch.num != 0)

## Test the quality of GIS using mine-55-metal.csv
metal.mine.05 <- read_csv("/Users/batta/Dropbox/phd4/monopsony/mining-r/mine-55th-metal.csv")
metal.mine.05 <- metal.mine.05 %>% 
	select(PROVINCE, COMPANY, MINESITE, LOCATION, LONGITUDE, LATITUDE)
test <- metal.mine.05 %>% 
	filter(is.na(LOCATION)==FALSE)
province <- str_replace(test$PROVINCE,"\\b[[:space:]]+\\b", "+" )
location <- str_replace_all(test$LOCATION,"\\b[[:space:]]*,[[:space:]]*\\b", "+" )
location <- str_replace_all(location, "\\b[[:space:]]+\\b","+")
location <- str_replace_all(location, "-","+")
minesite <- str_replace_all(test$MINESITE, "\\b[[:space:]]+\\b", "+" )
minesite <- str_replace_all(minesite,"The\\+","")
site.location <- paste0(minesite,"+", location)
site.location <- str_replace_all(site.location, "^\\+","")
gensearch <- "https://www.mindat.org/search.php?search="
advsearch <- "https://www.mindat.org/lsearch.php?adv=1&loc="
gensearch.link <- paste0(gensearch, site.location,"+",province,"+","canada")# need to combine with mine locations
advsearch.link <- paste0(advsearch, location,"&tlr=Canada")

# run the ## Advance search session again
advsearch.05 <- data.frame(advsearch.link, advmine.gis, advmine.gis2 , advsearch.not1, advsearch.num, mine.links, mine.links.num, picked.link)
advsearch.05$advsearch.num <- as.numeric(as.character(advsearch.05$advsearch.num))
tt <- str_replace(advsearch.05$advmine.gis2, "(~.*)", replacement = "")
tt[which(tt=="")] <- NA
advsearch.05$advmine.gis3 <- tt
test <- metal.mine.05 %>% 
	select(PROVINCE, MINESITE, COMPANY, LOCATION) %>% 
	filter(is.na(LOCATION)==FALSE)
tmp <- cbind(test, advsearch.05)
advsearch.05.test <- tmp %>% 
	filter(is.na(advmine.gis3)==FALSE)
ttt <- str_split(advsearch.05.test$advmine.gis3,",")
df <- data.frame(matrix(unlist(ttt), nrow=nrow(advsearch.05.test), byrow=T),stringsAsFactors=FALSE)
colnames(df) <- c("LATITUDE", "LONGITUDE")
advsearch.05.test <- cbind(advsearch.05.test,df)
write_csv(advsearch.05.test, "/Users/batta/Dropbox/phd4/monopsony/mining-r/advsearch-55-test.csv")
matched05 <- read_csv("/Users/batta/Dropbox/phd4/monopsony/mining-r/advsearch-55-matched.csv")
compare05 <- read_csv("/Users/batta/Dropbox/phd4/monopsony/map/2006_csd_map/matched-map55-boundary06.csv")

test <- left_join(matched05, compare05, by = c("PROVINCE" = "PROVINCE", "COMPANY" = "COMPANY",  "MINESITE" = "MINESITE", "LOCATION" = "LOCATION"))
test <- test %>% 
	select(PROVINCE, MINESITE, COMPANY, LOCATION, CSDUID.x, CSDUID.y, CSDNAME.x, CSDNAME.y)
same <- test %>% 
	filter(CSDUID.x == CSDUID.y) # 23 out of 32 is correct

## General search 
gensearch.result <- read_html(gensearch.link[1])
mine.loc <- gensearch.result %>% 
	html_node("br+ .thinlocrow a") %>% 
	capture.output()

gre.affix <- "loc-[0-9]*.html"
affix <- str_extract(mine.loc[2], gre.affix)
mine.link <- paste0("https://www.mindat.org/", affix)
mine.page <- read_html(mine.link)
gis.table <- mine.page %>% 
	html_node("table") %>% 
	html_table()
mine.gis <- matrix(length(advsearch.link),1)
mine.gis[1] <- gis.table[2,2]

	
gre.affix <- "loc-[0-9]*.html"
mine.gis <- matrix(length(gensearch.link),1)
for (i in 1:length(gensearch.link)) {
	search.result <- read_html(search.link[i])
	mine.loc <- search.result %>% 
		html_node("br+ .thinlocrow a") %>% 
		capture.output()
	affix <- str_extract(mine.loc[2], gre.affix)
	mine.link <- paste0("https://www.mindat.org/", affix)
	mine.page <- read_html(mine.link)
	gis.table <- mine.page %>% 
		html_node("table") %>% 
		html_table()
	mine.gis[i] <- gis.table[2,2]
}

	
link.affix <- search.result %>% 
	html_nodes("br+ .thinlocrow a") %>%
	html_attrs()
mine.link <- paste0(website, link.affix[1][[1]])
mine.page <- read_html(mine.link)
mine.cood <- mine.page %>% 
	html_nodes(".mindattable tr:nth-child(1) td") %>% 
	html_text()

