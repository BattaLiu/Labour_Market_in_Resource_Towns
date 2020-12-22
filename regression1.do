* Labour Markets in Resource Towns *
* Jiayi Liu *
* Created: Feb 2018*

* Combined the obs from different census. The criterion is 1) working in mining industry, 2) living in CSDs  with only one mine.
/*clear 
use "P:/Liu_5114/result/trimmed-census-data/1981-miners"
append using "P:/Liu_5114/result/trimmed-census-data/1986-miners"
append using "P:/Liu_5114/result/trimmed-census-data/1991-miners"
append using "P:/Liu_5114/result/trimmed-census-data/1996-miners"
append using "P:/Liu_5114/result/trimmed-census-data/2001-miners"
append using "P:/Liu_5114/result/trimmed-census-data/2006-miners"
save "P:/Liu_5114/result/trimmed-census-data/appended-miners", replace*/


/*clear 
use "P:/Liu_5114/result/trimmed-census-data/1981-miners"
append using "P:/Liu_5114/result/trimmed-census-data/1986-miners-v2"
append using "P:/Liu_5114/result/trimmed-census-data/1991-miners-v2"
append using "P:/Liu_5114/result/trimmed-census-data/1996-miners-v2"
append using "P:/Liu_5114/result/trimmed-census-data/2001-miners-v2"
append using "P:/Liu_5114/result/trimmed-census-data/2006-miners-v2"
save "P:/Liu_5114/result/trimmed-census-data/appended-miners-v2", replace*/

/* clear 
use "P:/Liu_5114/result/trimmed-census-data/1981-miners-v3"
append using "P:/Liu_5114/result/trimmed-census-data/1986-miners-v3"
append using "P:/Liu_5114/result/trimmed-census-data/1991-miners-v3"
append using "P:/Liu_5114/result/trimmed-census-data/1996-miners-v3"
append using "P:/Liu_5114/result/trimmed-census-data/2001-miners-v3"
append using "P:/Liu_5114/result/trimmed-census-data/2006-miners-v3"
save "P:/Liu_5114/result/trimmed-census-data/appended-miners-v3", replace */

clear
log using "P:\Liu_5114\log\regression1", replace
use "P:/Liu_5114/result/trimmed-census-data/appended-miners-v3"
keep if csdmetalcnt >= 5 & csdmetalcnt < .
*keep if csdmetalcnt >=30 & csdmetalcnt < . // important note: keep enough observation for a convincing regression result.
gen lwagesr = ln(wages_real) if wages_real>0 & wages_real<.
gen wagesr = wages_real if wages_real>0 & wages_real<.
gen lwkwagesr = ln(wkwages_real) if wkwages_real>0 & wkwages_real<.
gen wkwagesr = wkwages_real if wkwages_real>0 & wkwages_real<.

gen degr = 1 if degree==1 |degree==1.5
replace degr = 2 if degree>1.5 & degree!=.
replace degr =0 if degree<1 & degree!=.

gen exp = age - 18 if degr == 1
replace exp = age - 22 if degr == 2
replace exp = age - 15 if degr == 0

* Run regressions to get the residuals of individual. And then get the average weekly wage in each CSD.
regress lwkwagesr age i.degr i.sex weeks i.year
regress lwkwagesr age i.degr i.sex weeks i.year exp
regress lwkwagesr age i.degr i.sex weeks i.year i.marst 
regress lwkwagesr age i.degr i.sex weeks i.year i.marst i.pr
predict plwkwagesr, residual

regress wkwagesr age i.degr i.sex weeks i.year
regress wkwagesr age i.degr i.sex weeks i.year exp
regress wkwagesr age i.degr i.sex weeks i.year i.marst 
regress wkwagesr age i.degr i.sex weeks i.year i.marst i.pr
predict pwkwagesr, residual

sort pcsd year
by pcsd year: egen avelwr0 = mean(lwagesr)
by pcsd year: egen avelwwr0 = mean(lwkwagesr)
by pcsd year: egen medlwr0 = median(lwagesr)
by pcsd year: egen medlwwr0 = median(lwkwagesr)

egen group=group(pcsd year)
gen fitted_lwwr = .
gen fitted_lwr  = .
sum group

forval g = 1/`r(max)' {
	regress lwkwagesr age i.degr i.sex weeks if group == `g'
	predict wage
	replace fitted_lwwr = wage if group == `g'
	drop wage
	regress lwagesr age i.degr i.sex weeks  if  group == `g'
	predict wage
	replace fitted_lwr = wage if group == `g'
	drop wage
}
gen res_lwwr = lwkwagesr - fitted_lwwr
gen res_lwr = lwagesr - fitted_lwr

by year pcsd, sort: egen avelwwr = mean(res_lwwr)
by year pcsd, sort: egen avelwr = mean(res_lwr)
by year pcsd, sort: egen medlwwr = median(res_lwwr)
by year pcsd, sort: egen medlwr = median(res_lwr)


collapse csdmetalcnt csdcnt csdindcnt avelwwr0 avelwr0 medlwwr0 medlwr0 avelwwr avelwr medlwwr medlwr csdwkmetalwkwages, by (pcsd year)
sort pcsd year

by pcsd: gen dcsdmetalcnt = csdmetalcnt - csdmetalcnt[_n-1] if year == year[_n-1] + 5
by pcsd: gen dcsdcnt = csdcnt - csdcnt[_n-1] if year == year[_n-1] + 5
by pcsd: gen dcsdindcnt = csdindcnt - csdindcnt[_n-1] if year == year[_n-1] + 5
by pcsd: gen davelwwr = avelwwr - avelwwr[_n-1] if year == year[_n-1] + 5
by pcsd: gen davelwr = avelwr - avelwr[_n-1] if year == year[_n-1] + 5
by pcsd: gen dmedlwwr = medlwwr - medlwwr[_n-1] if year == year[_n-1] + 5
by pcsd: gen dmedlwr = medlwr - medlwr[_n-1] if year == year[_n-1] + 5
by pcsd: gen davelwwr0 = avelwwr0 - avelwwr0[_n-1] if year == year[_n-1] + 5
by pcsd: gen davelwr0 = avelwr0 - avelwr0[_n-1] if year == year[_n-1] + 5
by pcsd: gen dmedlwwr0 = medlwwr0 - medlwwr0[_n-1] if year == year[_n-1] + 5
by pcsd: gen dmedlwr0 = medlwr0 - medlwr0[_n-1] if year == year[_n-1] + 5

sort year
by year: regress davelwr dcsdmetalcnt
regress davelwr dcsdcnt i.year
regress davelwr dcsdindcnt i.year
regress davelwr dcsdmetalcnt i.year
sort year
by year: regress davelwwr dcsdmetalcnt
regress davelwwr dcsdcnt i.year
regress davelwwr dcsdindcnt i.year
regress davelwwr dcsdmetalcnt i.year

regress csdwkmetalwkwages dcsdmetalcnt
regress davelwr dcsdcnt 
regress davelwr dcsdindcnt
regress avelwr csdcnt
regress avelwr csdindcnt

regress dcsdcnt dcsdmetalcnt
regress dcsdindcnt dcsdmetalcnt

save "P:/Liu_5114/result/trimmed-census-data/wage-residual-2",replace
merge 1:1 pcsd year using "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-v2.dta"
save "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-residual-wage-2.dta", replace
log close
