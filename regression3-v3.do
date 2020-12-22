* Labour Markets in Resource Towns *
* Jiayi Liu *
* Created: April 2018*


clear
use "P:/Liu_5114/result/trimmed-census-data/appended-miners-v2"
gen lwagesr = ln(wages_real) if wages_real>0 & wages_real<.
gen wagesr = wages_real if wages_real>0 & wages_real<.
gen lwkwagesr = ln(wkwages_real) if wkwages_real>0 & wkwages_real<.
gen wkwagesr = wkwages_real if wkwages_real>0 & wkwages_real<.
gen lncsdmetalcnt = ln(csdmetalcnt) if csdmetalcnt>0 & csdmetalcnt<.
gen lncsdcnt = ln(csdcnt) if csdcnt>0 & csdcnt<.
gen lncsdindcnt = ln(csdindcnt) if csdindcnt>0 & csdindcnt<.
gen degr = 1 if degree==1 |degree==1.5
replace degr = 2 if degree>1.5 & degree!=.
replace degr =0 if degree<1 & degree!=.

gen exp = age - 18 if degr == 1
replace exp = age - 22 if degr == 2
replace exp = age - 15 if degr == 0

merge m:1 pcsd year using "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-v2.dta"
regress lwagesr age i.degr i.sex weeks i.year 
regress lwagesr age i.degr i.sex weeks i.year csdmetalcnt
regress lwagesr age i.degr i.sex weeks i.year csdindcnt
regress lwagesr age i.degr i.sex weeks i.year lnmineprice
regress lwagesr age i.degr i.sex weeks i.year csdmetalpcavail
regress lwagesr age i.degr i.sex weeks i.year csdmetalpcavail lncsdmetalcnt 
regress lwagesr age i.degr i.sex weeks i.year csdmetalpcavail csdmetalcnt
regress lwagesr age i.degr i.sex weeks i.year csdmetalpcavail lncsdcnt 
regress lwagesr age i.degr i.sex weeks i.year csdmetalpcavail csdcnt
regress lwagesr age i.degr i.sex weeks i.year csdmetalpcavail lncsdindcnt 
regress lwagesr age i.degr i.sex weeks i.year csdmetalpcavail csdindcnt

regress lwkwagesr age i.degr i.sex weeks i.year lnmineprice
regress lwkwagesr age i.degr i.sex weeks i.year csdmetalpcavail
regress lwkwagesr age i.degr i.sex weeks i.year csdmetalpcavail lncsdmetalcnt 
regress lwkwagesr age i.degr i.sex weeks i.year csdmetalpcavail csdmetalcnt
regress lwkwagesr age i.degr i.sex weeks i.year csdmetalpcavail lncsdcnt 
regress lwkwagesr age i.degr i.sex weeks i.year csdmetalpcavail csdcnt
regress lwkwagesr age i.degr i.sex weeks i.year csdmetalpcavail lncsdcnt 
regress lwkwagesr age i.degr i.sex weeks i.year csdmetalpcavail csdcnt

ivregress 2sls lwagesr (lncsdmetalcnt = lnmineprice) age i.degr i.sex weeks
ivregress 2sls lwkwagesr (lncsdmetalcnt = lnmineprice) age i.degr i.sex weeks
ivregress 2sls lwagesr (csdmetalpc = lnmineprice) age i.degr i.sex weeks
ivregress 2sls lwagesr (csdmetalpcavail = lnmineprice) age i.degr i.sex weeks
