* Labour Markets in Resource Towns *
* Jiayi Liu *
* Created: July 2018 *

* Check how many unchanged mining CSDs with mining info
clear
import delimited "P:\Liu_5114\mines-CSD\mine-CSD-8186"
rename sgccsd81 pcsd
merge m:1 pcsd using "P:\Liu_5114\result\handbook-data\1980-trimmed-price-real2002-CSD.dta"

clear
import delimited "P:\Liu_5114\mines-CSD\mine-CSD-8106"
save "P:\Liu_5114\mines-CSD\mine-CSD-8106", replace
rename sgccsd81 pcsd
merge m:1 pcsd using "P:\Liu_5114\result\handbook-data\1980-trimmed-price-real2002-CSD.dta"

clear
import delimited "P:\Liu_5114\mines-CSD\mine-CSD-8606"
save "P:\Liu_5114\mines-CSD\mine-CSD-8606", replace
rename sgccsd86 pcsd
merge m:1 pcsd using "P:\Liu_5114\result\handbook-data\1985-trimmed-price-real2002-CSD.dta"

clear
use "P:\Liu_5114\mines-CSD\mine-CSD-8606"
duplicates drop sgccsd86, force
merge 1:m sgccsd86 using "P:\Liu_5114\mines-CSD\mine-CSD-8106"
keep if _merge ==1
drop _merge
rename sgccsd86 pcsd
merge 1:1 pcsd using "P:\Liu_5114\result\handbook-data\1985-trimmed-price-real2002-CSD.dta"
keep if _merge ==3

* transfer csv "mine-CSD-81-mainCSD16" to dta "mine-CSD-81-mainCSD16"
clear
import delimited "P:\Liu_5114\mines-CSD\mine-CSD-81-mainCSD16"
sort sgccsd81
gen conscsdid = _n
drop v1
replace sgccsd86 = "" if sgccsd86 == "NA"
replace sgccsd91 = "" if sgccsd91 == "NA"
replace sgccsd96 = "" if sgccsd96 == "NA"
replace sgccsd01 = "" if sgccsd01 == "NA"
replace sgccsd06 = "" if sgccsd06 == "NA"
replace sgccsd11 = "" if sgccsd11 == "NA"
replace sgccsd16 = "" if sgccsd16 == "NA"
replace minecsd86 = "" if minecsd86 == "NA"
replace minecsd91 = "" if minecsd91 == "NA"
replace minecsd96 = "" if minecsd96 == "NA"
replace minecsd01 = "" if minecsd01 == "NA"
replace minecsd06 = "" if minecsd06 == "NA"
replace minecsd11 = "" if minecsd11 == "NA"
replace minecsd16 = "" if minecsd16 == "NA"
destring sgccsd*, replace
destring minecsd*, replace

* create variables indicateing the close year and reopen year of mines
gen tmp86 = minecsd86 
replace tmp86 = 0 if tmp86 ==. & sgccsd86 !=.
gen tmp91 = minecsd91 
replace tmp91 = 0 if tmp91 ==. & sgccsd91 !=.
gen tmp96 = minecsd96 
replace tmp96 = 0 if tmp96 ==. & sgccsd96 !=.
gen tmp01 = minecsd01 
replace tmp01 = 0 if tmp01 ==. & sgccsd01 !=.
gen tmp06 = minecsd06 
replace tmp06 = 0 if tmp06 ==. & sgccsd06 !=.
gen tmp11 = minecsd11 
replace tmp11 = 0 if tmp11 ==. & sgccsd11 !=.
gen tmp16 = minecsd16 
replace tmp16 = 0 if tmp16 ==. & sgccsd16 !=.

gen diff86 = tmp86 - 1 
gen diff91 = tmp91 - tmp86
gen diff96 = tmp96 - tmp91
gen diff01 = tmp01 - tmp96
gen diff06 = tmp06 - tmp01
gen diff11 = tmp11 - tmp06
gen diff16 = tmp16 - tmp11

gen closeyear = 1986 if diff86 == -1
replace closeyear = 1991 if diff91 == -1
replace closeyear = 1996 if diff96 == -1
replace closeyear = 2001 if diff01 == -1
replace closeyear = 2006 if diff06 == -1
replace closeyear = 2011 if diff11 == -1
replace closeyear = 2016 if diff16 == -1
replace closeyear = 1234 if tmp86 ==1 & tmp91 ==1 & tmp96 ==1 & tmp01 == 1 & tmp06 ==1 & tmp11 == 1 & tmp16 ==1

gen reopenyear = 1991 if diff91 == 1
replace reopenyear = 1996 if diff96 == 1
replace reopenyear = 2001 if diff01 == 1
replace reopenyear = 2006 if diff06 == 1
replace reopenyear = 2011 if diff11 == 1
replace reopenyear = 2016 if diff16 == 1
drop tmp*

save "P:\Liu_5114\mines-CSD\mine-CSD-81-mainCSD16", replace
rename sgccsd81 pcsd
merge m:1 pcsd using "P:\Liu_5114\result\handbook-data\1980-trimmed-price-real2002-CSD.dta"
count if _merge ==3 & sgccsd16!=.


