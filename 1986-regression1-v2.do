* Labour Market in Resource Towns *
* Jiayi Liu *
* Created: Feb 2018*

/* Data cleaning, transfering 
use V:\Liu_5114\test\1986.DTA 
keep age AGE_IMM marst pop cma CMA5 csdtype ctname pcd PCD5 pcsd PCSD5 pr PR5 rusize RUUB5 cow cowd fptim hours IND70 IND80 layab LF71 lftag lftaghus lokwk lstwk nujob OCC71 OCC81 reasn weeks workact dgreer hlos hloshus hloswife cerbar trnucr selfi totinc wages childcount citizen
save "V:\Liu_5114\data-1981\1986-trimmed.dta" */

* used variables: ind80, pcsd,wages, weeks, age, hgradr, ps_otr, ps_uvr, hlos, dgreer
clear
log using "P:\Liu_5114\log\1986-regression1-v2", replace
use "P:\Liu_5114\data\1986.dta"
keep age marst sex pop cma csdtype pcd pcsd pcsd5 pr rusize mob5 cowd fptim hours ind70 layab weeks workact dgreer totinc wages citizen omp grosrt
rename ind70 industry
gen year = 1986 

/* check the percentage of people working in industry 14 (metal mines) */
gen indmetal = 1 if industry >= 9 & industry <= 12
replace indmetal = 0 if indmetal != 1
by pcsd, sort: egen csdmetalcnt = total(indmetal)
by pcsd, sort: egen csdcnt = count(pcsd)
gen csdmetalpc = csdmetalcnt/csdcnt

/* Calculate the percentage of people working in industry metal (metal mines), 
compared to total working population*/ 
gen indavail = 1 if industry != 267
replace indavail = 0 if industry == 267
by pcsd, sort: egen csdindcnt = total(indavail)
gen csdmetalpcavail = csdmetalcnt/csdindcnt

/* Check the percentage of income from mining industry 14 */
by pcsd, sort: egen csdinc= total (wages)
gen indmetalwages = wages if indmetal ==1
replace indmetalwages = 0 if indmetal ==0
* by pcsd indmetal, sort: egen csdmetalinc=total(wages)
by pcsd, sort: egen csdmetalinc=total(indmetalwages)
gen csdmetalincpc = csdmetalinc/csdinc

gen wkwages = wages/weeks if weeks >0
gen wkindmetalwages = wkwages if indmetal ==1

by pcsd, sort: egen csdwkwages = mean(wkwages)
by pcsd, sort: egen csdwkmetalwkwages = mean(wkindmetalwages)



/* Check the average age in different CSDs*/
by pcsd, sort: egen csdagemean = mean(age)
by pcsd, sort: egen csdagemedian = median(age)
by pcsd, sort: egen csdagemode = mode(age)

gen degree = 1 if dgreer == 5 
replace degree = 1.5 if dgreer == 8 | dgreer == 11 | dgreer == 3 
replace degree = 2 if dgreer ==  1
replace degree = 2.5 if dgreer == 2 | dgreer == 7
replace degree = 3 if dgreer == 6
replace degree = 4 if dgreer == 4
replace degree = 0 if dgreer == 9
replace degree = . if dgreer == 10

gen csdhisch = 1 if degree==1 |degree==1.5
gen csduniv = 1 if degree>1.5 & degree!=.
gen csdlow =1 if degree<1 & degree!=.
gen csd15 = 1 if age >14 

by pcsd, sort: egen csdhischcnt = total(csdhisch==1)
by pcsd, sort: egen csdunivcnt = total(csduniv ==1)
by pcsd, sort: egen csdlowcnt = total(csdlow ==1)
by pcsd, sort: egen csd15cnt = total(csd15 ==1) 

gen csdhischpc = csdhischcnt/csd15cnt 
gen csdunivpc = csdunivcnt/csd15cnt
gen csdlowpc = csdlowcnt/csd15cnt
gen csddgreepc = (csdhischcnt + csdunivcnt)/csd15cnt

/* inflation adjustment */
scalar cpi2002 = 63
// incomes
gen wages_real = wages*100/cpi2002
gen totinc_real = totinc*100/cpi2002
gen wkwages_real = wkwages*100/cpi2002 
// cost
gen omp_real = omp*100/cpi2002
gen grosrt_real = grosrt*100/cpi2002

/* clean the citizen variable */
gen canadian = 1 if citizen !=3 & citizen != 4
replace canadian = 0 if canadian != 1
gen canbybirth = 1 if citizen == 1 & citizen == 5 & citizen ==6 & citizen ==10
replace canbybirth = 0 if canbybirth != 1

merge m:1 pcsd using "P:\Liu_5114\result\CSDs\1986-mining-CSD-map"
rename (_merge dup) (res_in_mineCSD res_CSD_dup)

merge m:1 pcsd using "P:/Liu_5114/result/handbook-data/1985-trimmed-price-real2002-CSD", keepusing (company)
rename _merge res_in_mineCSD_info

keep if indmetal == 1 & res_in_mineCSD == 3
save "P:/Liu_5114/result/trimmed-census-data/1986-miners-v3", replace
log close
