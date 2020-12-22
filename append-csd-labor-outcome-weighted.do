* Labour Markets in Resource Towns *
* Jiayi Liu *
* Sep 2018 *


************************************
* Label the consistent mining CSD and add mine prices to mining CSDs. 
* This file is similar to merge-csd-labor-outcome-weighted.do in terms of structure.
************************************
clear 
use "P:\Liu_5114\result\labor market outcome\1981-labor-outcome2-weighted.dta"
rename pcsd sgccsd81
merge 1:1 sgccsd81 using "P:\Liu_5114\result\CSDs\1981-mining-CSD-map-consistent16"
rename (_merge dup) (res_in_mineCSD81 res_CSD_dup81)
rename sgccsd81 pcsd
gen sgccsd81 = pcsd if res_in_mineCSD81 ==3
merge 1:1 pcsd using "P:/Liu_5114/result/handbook-data/1980-trimmed-price-real2002-CSD", keepusing(*1979)
drop if _merge ==2
rename _merge res_in_mineCSD_info
rename (minepriceres1979 minepriceprod1979 mineprice1979 lnmineprice1979) (minepriceres minepriceprod mineprice lnmineprice)
gen dlnmineprice =.
save "P:\Liu_5114\result\labor market outcome\1981-labor-outcome3-weighted.dta", replace

clear 
use "P:\Liu_5114\result\labor market outcome\1986-labor-outcome2-weighted.dta"
rename pcsd sgccsd86
merge 1:m sgccsd86 using "P:\Liu_5114\result\CSDs\1981-mining-CSD-map-consistent16" // 1:m because there are some missing sgccsd86 for mining CSDs in 1981
keep if sgccsd86 !=.  // because some mining CSDs of 1980 don't have comparable CSD in 1986.
replace year = 1986 if year ==. // because some CSDs don't have obs in census
rename (_merge dup) (res_in_mineCSD81 res_CSD_dup81)
rename sgccsd81 pcsd
merge m:1 pcsd using "P:/Liu_5114/result/handbook-data/1980-trimmed-price-real2002-CSD", keepusing(*1984) // m:1 because there are lots of unmatched CSDs from last match
drop if _merge ==2
rename _merge res_in_mineCSD_info
rename pcsd sgccsd81
rename sgccsd86 pcsd
gen sgccsd86 = pcsd if res_in_mineCSD81 !=1
rename (minepriceres1984 minepriceprod1984 mineprice1984 lnmineprice1984 dlnmineprice1984) (minepriceres minepriceprod mineprice lnmineprice dlnmineprice)
save "P:\Liu_5114\result\labor market outcome\1986-labor-outcome3-weighted.dta", replace

clear 
use "P:\Liu_5114\result\labor market outcome\1991-labor-outcome2-weighted.dta"
rename pcsd sgccsd91
merge 1:m sgccsd91 using "P:\Liu_5114\result\CSDs\1981-mining-CSD-map-consistent16"
keep if sgccsd91 !=. 
replace year = 1991 if year ==.
rename (_merge dup) (res_in_mineCSD81 res_CSD_dup81)
rename sgccsd81 pcsd
merge m:1 pcsd using "P:/Liu_5114/result/handbook-data/1980-trimmed-price-real2002-CSD", keepusing(*1989)
drop if _merge ==2
rename _merge res_in_mineCSD_info
rename pcsd sgccsd81
rename sgccsd91 pcsd
gen sgccsd91 = pcsd if res_in_mineCSD81 !=1
rename (minepriceres1989 minepriceprod1989 mineprice1989 lnmineprice1989 dlnmineprice1989) (minepriceres minepriceprod mineprice lnmineprice dlnmineprice)
save "P:\Liu_5114\result\labor market outcome\1991-labor-outcome3-weighted.dta", replace

clear 
use "P:\Liu_5114\result\labor market outcome\1996-labor-outcome2-weighted.dta"
rename pcsd sgccsd96
merge 1:m sgccsd96 using "P:\Liu_5114\result\CSDs\1981-mining-CSD-map-consistent16"
keep if sgccsd96 !=. 
replace year = 1996 if year ==.
rename (_merge dup) (res_in_mineCSD81 res_CSD_dup81)
rename sgccsd81 pcsd
merge m:1 pcsd using "P:/Liu_5114/result/handbook-data/1980-trimmed-price-real2002-CSD", keepusing(*1994)
drop if _merge ==2
rename _merge res_in_mineCSD_info
rename pcsd sgccsd81
rename sgccsd96 pcsd
gen sgccsd96 = pcsd if res_in_mineCSD81 !=1
rename (minepriceres1994 minepriceprod1994 mineprice1994 lnmineprice1994 dlnmineprice1994) (minepriceres minepriceprod mineprice lnmineprice dlnmineprice)
save "P:\Liu_5114\result\labor market outcome\1996-labor-outcome3-weighted.dta", replace


clear 
use "P:\Liu_5114\result\labor market outcome\2001-labor-outcome2-weighted.dta"
rename pcsd sgccsd01
merge 1:m sgccsd01 using "P:\Liu_5114\result\CSDs\1981-mining-CSD-map-consistent16"
keep if sgccsd01 !=. 
replace year = 2001 if year ==.
rename (_merge dup) (res_in_mineCSD81 res_CSD_dup81)
rename sgccsd81 pcsd
merge m:1 pcsd using "P:/Liu_5114/result/handbook-data/1980-trimmed-price-real2002-CSD", keepusing(*1999)
drop if _merge ==2
rename _merge res_in_mineCSD_info
rename pcsd sgccsd81
rename sgccsd01 pcsd
gen sgccsd01 = pcsd if res_in_mineCSD81 !=1
rename (minepriceres1999 minepriceprod1999 mineprice1999 lnmineprice1999 dlnmineprice1999) (minepriceres minepriceprod mineprice lnmineprice dlnmineprice)
save "P:\Liu_5114\result\labor market outcome\2001-labor-outcome3-weighted.dta", replace

clear 
use "P:\Liu_5114\result\labor market outcome\2006-labor-outcome2-weighted.dta"
rename pcsd sgccsd06
merge 1:m sgccsd06 using "P:\Liu_5114\result\CSDs\1981-mining-CSD-map-consistent16"
keep if sgccsd06 !=. 
replace year = 2006 if year ==.
rename (_merge dup) (res_in_mineCSD81 res_CSD_dup81)
rename sgccsd81 pcsd
merge m:1 pcsd using "P:/Liu_5114/result/handbook-data/1980-trimmed-price-real2002-CSD", keepusing(*2004)
drop if _merge ==2
rename _merge res_in_mineCSD_info
rename pcsd sgccsd81
rename sgccsd06 pcsd
gen sgccsd06 = pcsd if res_in_mineCSD81 !=1
rename (minepriceres2004 minepriceprod2004 mineprice2004 lnmineprice2004 dlnmineprice2004) (minepriceres minepriceprod mineprice lnmineprice dlnmineprice)
save "P:\Liu_5114\result\labor market outcome\2006-labor-outcome3-weighted.dta", replace

clear 
use "P:\Liu_5114\result\labor market outcome\2011-labor-outcome2-weighted.dta"
rename pcsd sgccsd11
merge 1:m sgccsd11 using "P:\Liu_5114\result\CSDs\1981-mining-CSD-map-consistent16"
keep if sgccsd11 !=. 
replace year = 2011 if year ==.
rename (_merge dup) (res_in_mineCSD81 res_CSD_dup81)
rename sgccsd81 pcsd
merge m:1 pcsd using "P:/Liu_5114/result/handbook-data/1980-trimmed-price-real2002-CSD", keepusing(*2009)
drop if _merge ==2
rename _merge res_in_mineCSD_info
rename pcsd sgccsd81
rename sgccsd11 pcsd
gen sgccsd11 = pcsd if res_in_mineCSD81 !=1
rename (minepriceres2009 minepriceprod2009 mineprice2009 lnmineprice2009 dlnmineprice2009) (minepriceres minepriceprod mineprice lnmineprice dlnmineprice)
save "P:\Liu_5114\result\labor market outcome\2011-labor-outcome3-weighted.dta", replace

clear 
use "P:\Liu_5114\result\labor market outcome\1981-labor-outcome3-weighted.dta"
append using "P:\Liu_5114\result\labor market outcome\1986-labor-outcome3-weighted.dta"
append using "P:\Liu_5114\result\labor market outcome\1991-labor-outcome3-weighted.dta"
append using "P:\Liu_5114\result\labor market outcome\1996-labor-outcome3-weighted.dta"
append using "P:\Liu_5114\result\labor market outcome\2001-labor-outcome3-weighted.dta"
append using "P:\Liu_5114\result\labor market outcome\2006-labor-outcome3-weighted.dta"
append using "P:\Liu_5114\result\labor market outcome\2011-labor-outcome3-weighted.dta"

drop if pcsd ==. | year == .
gen minecsd = 1 if year == 1981 & sgccsd81 !=.
replace minecsd = 0 if year == 1981 & minecsd !=1 & sgccsd81 !=.
replace minecsd = 1 if year == 1986 & minecsd86 ==1 
replace minecsd = 0 if year == 1986 & minecsd !=1 & sgccsd86 !=.
replace minecsd = 1 if year == 1991 & minecsd91 ==1 
replace minecsd = 0 if year == 1991 & minecsd !=1 & sgccsd91 !=.
replace minecsd = 1 if year == 1996 & minecsd96 ==1 
replace minecsd = 0 if year == 1996 & minecsd !=1 & sgccsd96 !=.
replace minecsd = 1 if year == 2001 & minecsd01 ==1 
replace minecsd = 0 if year == 2001 & minecsd !=1 & sgccsd01 !=.
replace minecsd = 1 if year == 2006 & minecsd06 ==1 
replace minecsd = 0 if year == 2006 & minecsd !=1 & sgccsd06 !=.
replace minecsd = 1 if year == 2011 & minecsd11 ==1 
replace minecsd = 0 if year == 2011 & minecsd !=1 & sgccsd11 !=.

save "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-weighted.dta", replace




clear 
use "P:\Liu_5114\result\labor market outcome\labor-outcome-appended.dta"
* Create a graph of metal mining worker percentage for different years
generate double pccat = recode(csdmetalpc, 0.01, 0.02, 0.03, 0.04, 0.05)
twoway histogram pccat, by(year)
graph save "P:\Liu_5114\result\labor market outcome\density-csd-metal-mining", replace
twoway histogram pccat, by(year) frac
graph save "P:\Liu_5114\result\labor market outcome\density-csd-metal-mining-frac", replace

generate double pccatavail = recode(csdmetalpcavail, 0.01, 0.02, 0.03, 0.04, 0.05)
twoway histogram pccatavail, by(year)
graph save "P:\Liu_5114\result\labor market outcome\density-csd-metal-mining-avail", replace
twoway histogram pccatavail, by(year) frac
graph save "P:\Liu_5114\result\labor market outcome\density-csd-metal-mining-avail-frac", replace

/* by pccat year, sort: egen pccatcnt = count(pccat)
by pccatavail year, sort: egen pccatavailcnt = count(pccatavail)
by year, sort: egen yearcnt = count (year)
gen pccatpc = pccatcnt/yearcnt
by pcsd, sort: egen csdyearcnt = count(year)*/

* Create a graph of metal mining total income percentage for different years
generate double incpccat = recode(csdmetalincpc, 0.01, 0.02, 0.03, 0.04, 0.05)
twoway histogram incpccat, by(year)
* title( "density of CSDs with different metal mining population percentage, census years 1981-2006")
graph save "P:\Liu_5114\result\labor market outcome\density-csd-metal-mining-income", replace
twoway histogram incpccat, by(year) frac
graph save "P:\Liu_5114\result\labor market outcome\density-csd-metal-mining-income-frac", replace

* Create a graph of ave weekly income across csds in the same category
twoway scatter csdwkwages pcsd, by(pccat year)
twoway scatter csdwkmetalwkwages pcsd, by(pccat year)
* Create a graph of average age in different CSDs, categorized by pccat
twoway scatter csdagemean pcsd, by(pccat year)
graph save "P:\Liu_5114\result\labor market outcome\csd-age-mean", replace

twoway scatter csdagemedian pcsd, by(pccat year)
graph save "P:\Liu_5114\result\labor market outcome\csd-age-median", replace

twoway scatter csdagemode pcsd, by(pccat year)
graph save "P:\Liu_5114\result\labor market outcome\csd-age-mode", replace

by pccat year, sort: egen groupwkwages = mean(csdwkwages)
by pccat year, sort: egen groupmetalwkwages = mean(csdwkmetalwkwages)

by pccat year, sort: egen groupagemean = mean(csdagemean)
by pccat year, sort: egen groupagemedian = mean(csdagemedian)
by pccat year, sort: egen groupagemode = mean(csdagemode)
* collapse groupwkwages groupmetalwkwages groupagemean groupagemedian groupagemode, by (pccat year)
* save "P:\Liu_5114\result\labor market outcome\pccat-category.dta", replace


