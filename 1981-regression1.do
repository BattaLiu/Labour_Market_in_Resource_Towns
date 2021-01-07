* Labour Markets in Resource Towns *
* Jiayi Liu *
* Created: Jan 2018*


* used variables: industry, pcsd, pow, wages, weeks, age, hgradr, ps_otr, ps_uvr, hlos, dgreer
clear 
/*log using "P:\Liu_5114\log\1981-Jan19", replace
log close */
use "P:\Liu_5114\data\1981.dta"
keep age marst sex pop cma csdtype pcd pcsd pcsd5 pr rusize mob5 cowd fptim hours industry layab weeks workact dgreer totinc wages citizen value omp grosrt pit
gen year = 1981
/* Calculate the percentage of people working in industry metal (metal mines),
compared total population */
gen indmetal = 1 if industry >=22 & industry <=27
replace indmetal = 0 if indmetal !=1
by pcsd, sort: egen csdmetalcnt = total(indmetal)
by pcsd, sort: egen csdcnt = count(pcsd)
gen csdmetalpc = csdmetalcnt/csdcnt

/* sum csdmetalpc
sum csdmetalpc, detail
count if csdmetalpc>0 */

/* Calculate the percentage of people working in industry metal (metal mines), 
compared to total working population*/ 
gen indavail = 1 if industry != 330
replace indavail = 0 if industry ==330
by pcsd, sort: egen csdindcnt = total(indavail)
gen csdmetalpcavail = csdmetalcnt/csdindcnt

/* Calculate the percentage of people income from mining industry metal */
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

/*gen csdmine=1 if csdmetalincpc>=csdmetalpc & csdmetalincpc!= 0 & csdmetalpc !=0
replace csdmine = 0 if csdmine == .
count if indmetal>0 */

/* list CSDs with high mining population and high mining income
list pcsd csdmetalincpc csdmetalpc if csdmetalincpc>0.02 & csdmetalpc > 0.02
gsort -csdmetalincpc -csdmetalpc pcsd 
* pctile pctest= csdmetalpc, nq(1000)
* list pctest in 1/10 */

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


/* compare the different definition of obs, unfinished*/
count if indmetal ==1

/* inflation adjustment */
scalar cpi2002 = 44
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



/* add mine location info from map and mine grade info from Canadian Mines Handbook */
// indicate whether a CSD has mines and how many mines located in it.
merge m:1 pcsd using "P:\Liu_5114\result\CSDs\1981-mining-CSD-map"
rename (_merge dup) (res_in_mineCSD res_CSD_dup)

/* merge m:1 pow using "P:\Liu_5114\result\CSDs\1981-mining-CSD-map2"
* rename (_merge company location dup) (pow_in_mineCSD pow_company pow_mine_location pow_csd_dup)
* keep if pow_in_mineCSD!=2
rename (_merge dup) (pow_in_mineCSD pow_csd_dup)*/

// indicate whether mine info is collected successfully
merge m:1 pcsd using "P:/Liu_5114/result/handbook-data/1980-trimmed-price-real2002-CSD", keepusing (company)
rename _merge res_in_mineCSD_info

keep if indmetal == 1 & res_in_mineCSD == 3 & res_CSD_dup==0
save "P:/Liu_5114/result/trimmed-census-data/1981-miners", replace
