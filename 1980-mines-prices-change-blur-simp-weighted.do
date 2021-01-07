* Labour Markets in Resource Towns *
* Jiayi Liu *
* Created: July 2018*
* Last modified: Sep 2018 *

/* This file runs the regression of labour market characteristics_it on CSD dummies and year dummies and mine existing dummies */
**************** Regressions ***********************
clear
use "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-weighted.dta", clear
keep if sgccsd81 != . & sgccsd86 != . & sgccsd91 != . & sgccsd96 != . &sgccsd01 != . & sgccsd06 != .
gen lncsdcnt = ln(csdcnt)
reg lncsdcnt i.minecsd i.year i.conscsdid 
reg csdcnt i.minecsd i.year i.conscsdid

gen lncsdmetalcnt = ln(csdmetalcnt)
reg lncsdmetalcnt i.minecsd i.year i.conscsdid

reg csdmetalpc i.minecsd i.year i.conscsdid

gen lncsdmetalpcavail = ln(csdmetalpcavail)
reg lncsdmetalpcavail i.minecsd i.year i.conscsdid
reg csdmetalpcavail i.minecsd i.year i.conscsdid

gen lncsdwkwagesmeanr = ln(csdwkwagesmeanr)
reg lncsdwkwagesmeanr i.minecsd i.year i.conscsdid
reg csdwkwagesmeanr i.minecsd i.year i.conscsdid

gen lncsdmetalwkwagesmeanr = ln(csdmetalwkwagesmeanr)
reg lncsdmetalwkwagesmeanr i.minecsd i.year i.conscsdid
reg csdmetalwkwagesmeanr i.minecsd i.year i.conscsdid

**************** Graphs ***********************
use "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-weighted.dta", clear
keep if sgccsd81 != . & sgccsd86 != . & sgccsd91 != . & sgccsd96 != . &sgccsd01 != . & sgccsd06 != .
drop if reopenyear != .
keep csdcnt conscsdid year closeyear
reshape wide csdcnt, i(conscsdid closeyear) j(year)
collapse (mean) csdcnt*, by (closeyear)
reshape long csdcnt, i(closeyear) j(year)
reshape wide csdcnt, i(year) j(closeyear)
graph twoway line csdcnt* year
graph save "P:\Liu_5114\result\labor market outcome\csdcnt-constant8106-blur-weighted", replace


use "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-weighted.dta", clear
keep if sgccsd81 != . & sgccsd86 != . & sgccsd91 != . & sgccsd96 != . &sgccsd01 != . & sgccsd06 != .
drop if reopenyear != .
keep csdcnt conscsdid year closeyear
replace closeyear = 1234 if closeyear ==.
sort year closeyear
seperate csdcnt, by(conscsdid)
drop csdcnt
count if closeyear ==1986
count if closeyear ==1991
count if closeyear ==1996
count if closeyear ==2001
count if closeyear ==2006
count if closeyear ==1234
graph twoway line csdcnt* year if closeyear == 1986, legend(off)
graph twoway line csdcnt* year if closeyear == 1991, legend(off)
graph twoway line csdcnt* year if closeyear == 1996, legend(off)
graph twoway line csdcnt* year if closeyear == 2001, legend(off)
graph twoway line csdcnt* year if closeyear == 2006, legend(off)
graph twoway line csdcnt* year if closeyear == 1234, legend(off)
graph twoway line csdcnt* year , by(closeyear)

use "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-weighted.dta", clear
keep if sgccsd81 != . & sgccsd86 != . & sgccsd91 != . & sgccsd96 != . &sgccsd01 != . & sgccsd06 != .
drop if reopenyear != .
keep csdmetalcnt conscsdid year closeyear
replace closeyear = 1234 if closeyear ==.
reshape wide csdmetalcnt, i(conscsdid closeyear) j(year)
collapse (mean) csdmetalcnt*, by (closeyear)
reshape long csdmetalcnt, i(closeyear) j(year)
reshape wide csdmetalcnt, i(year) j(closeyear)
graph twoway line csdmetalcnt* year
graph save "P:\Liu_5114\result\labor market outcome\csdmetalcnt-constant8106-blur-weighted", replace


use "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-weighted.dta", clear
keep if sgccsd81 != . & sgccsd86 != . & sgccsd91 != . & sgccsd96 != . &sgccsd01 != . & sgccsd06 != .
drop if reopenyear != .
keep csdmetalcnt conscsdid year closeyear
replace closeyear = 1234 if closeyear ==.
sort year closeyear
seperate csdmetalcnt, by(conscsdid)
drop csdmetalcnt
count if closeyear ==1986
count if closeyear ==1991
count if closeyear ==1996
count if closeyear ==2001
count if closeyear ==2006
count if closeyear ==1234
graph twoway line csdmetalcnt* year if closeyear == 1986, legend(off)
graph twoway line csdmetalcnt* year if closeyear == 1991, legend(off)
graph twoway line csdmetalcnt* year if closeyear == 1996, legend(off)
graph twoway line csdmetalcnt* year if closeyear == 2001, legend(off)
graph twoway line csdmetalcnt* year if closeyear == 2006, legend(off)
graph twoway line csdmetalcnt* year if closeyear == 1234, legend(off)
graph twoway line csdmetalcnt* year , by(closeyear)

use "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-weighted.dta", clear
keep if sgccsd81 != . & sgccsd86 != . & sgccsd91 != . & sgccsd96 != . &sgccsd01 != . & sgccsd06 != .
drop if reopenyear != .
keep csdmetalpc conscsdid year closeyear
replace closeyear = 1234 if closeyear ==.
reshape wide csdmetalpc, i(conscsdid closeyear) j(year)
collapse (mean) csdmetalpc*, by (closeyear)
reshape long csdmetalpc, i(closeyear) j(year)
reshape wide csdmetalpc, i(year) j(closeyear)
graph twoway line csdmetalpc* year
graph save "P:\Liu_5114\result\labor market outcome\csdmetalpc-constant8106-blur-weighted", replace


use "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-weighted.dta", clear
keep if sgccsd81 != . & sgccsd86 != . & sgccsd91 != . & sgccsd96 != . &sgccsd01 != . & sgccsd06 != .
drop if reopenyear != .
keep csdmetalpc conscsdid year closeyear
replace closeyear = 1234 if closeyear ==.
sort year closeyear
seperate csdmetalpc, by(conscsdid)
drop csdmetalpc
count if closeyear ==1986
count if closeyear ==1991
count if closeyear ==1996
count if closeyear ==2001
count if closeyear ==2006
count if closeyear ==1234
graph twoway line csdmetalpc* year if closeyear == 1986, legend(off)
graph twoway line csdmetalpc* year if closeyear == 1991, legend(off)
graph twoway line csdmetalpc* year if closeyear == 1996, legend(off)
graph twoway line csdmetalpc* year if closeyear == 2001, legend(off)
graph twoway line csdmetalpc* year if closeyear == 2006, legend(off)
graph twoway line csdmetalpc* year if closeyear == 1234, legend(off)
graph twoway line csdmetalpc* year , by(closeyear)

use "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-weighted.dta", clear
keep if sgccsd81 != . & sgccsd86 != . & sgccsd91 != . & sgccsd96 != . &sgccsd01 != . & sgccsd06 != .
drop if reopenyear != .
keep csdmetalpcavail conscsdid year closeyear
replace closeyear = 1234 if closeyear ==.
reshape wide csdmetalpcavail, i(conscsdid closeyear) j(year)
collapse (mean) csdmetalpcavail*, by (closeyear)
reshape long csdmetalpcavail, i(closeyear) j(year)
reshape wide csdmetalpcavail, i(year) j(closeyear)
graph twoway line csdmetalpcavail* year
graph save "P:\Liu_5114\result\labor market outcome\csdmetalpcavail-constant8106-blur-weighted", replace


use "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-weighted.dta", clear
keep if sgccsd81 != . & sgccsd86 != . & sgccsd91 != . & sgccsd96 != . &sgccsd01 != . & sgccsd06 != .
drop if reopenyear != .
keep csdmetalpcavail conscsdid year closeyear
replace closeyear = 1234 if closeyear ==.
sort year closeyear
seperate csdmetalpcavail, by(conscsdid)
drop csdmetalpcavail
count if closeyear ==1986
count if closeyear ==1991
count if closeyear ==1996
count if closeyear ==2001
count if closeyear ==2006
count if closeyear ==1234
graph twoway line csdmetalpcavail* year if closeyear == 1986, legend(off)
graph twoway line csdmetalpcavail* year if closeyear == 1991, legend(off)
graph twoway line csdmetalpcavail* year if closeyear == 1996, legend(off)
graph twoway line csdmetalpcavail* year if closeyear == 2001, legend(off)
graph twoway line csdmetalpcavail* year if closeyear == 2006, legend(off)
graph twoway line csdmetalpcavail* year if closeyear == 1234, legend(off)
graph twoway line csdmetalpcavail* year , by(closeyear)

use "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-weighted.dta", clear
keep if sgccsd81 != . & sgccsd86 != . & sgccsd91 != . & sgccsd96 != . &sgccsd01 != . & sgccsd06 != .
drop if reopenyear != .
keep csdwkwagesmeanr conscsdid year closeyear
replace closeyear = 1234 if closeyear ==.
reshape wide csdwkwagesmeanr, i(conscsdid closeyear) j(year)
collapse (mean) csdwkwagesmeanr*, by (closeyear)
reshape long csdwkwagesmeanr, i(closeyear) j(year)
reshape wide csdwkwagesmeanr, i(year) j(closeyear)
graph twoway line csdwkwagesmeanr* year
graph save "P:\Liu_5114\result\labor market outcome\csdwkwagesmeanr-constant8106-blur-weighted", replace


use "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-weighted.dta", clear
keep if sgccsd81 != . & sgccsd86 != . & sgccsd91 != . & sgccsd96 != . &sgccsd01 != . & sgccsd06 != .
drop if reopenyear != .
keep csdwkwagesmeanr conscsdid year closeyear
replace closeyear = 1234 if closeyear ==.
sort year closeyear
seperate csdwkwagesmeanr, by(conscsdid)
drop csdwkwagesmeanr
count if closeyear ==1986
count if closeyear ==1991
count if closeyear ==1996
count if closeyear ==2001
count if closeyear ==2006
count if closeyear ==1234
graph twoway line csdwkwagesmeanr* year if closeyear == 1986, legend(off)
graph twoway line csdwkwagesmeanr* year if closeyear == 1991, legend(off)
graph twoway line csdwkwagesmeanr* year if closeyear == 1996, legend(off)
graph twoway line csdwkwagesmeanr* year if closeyear == 2001, legend(off)
graph twoway line csdwkwagesmeanr* year if closeyear == 2006, legend(off)
graph twoway line csdwkwagesmeanr* year if closeyear == 1234, legend(off)
graph twoway line csdwkwagesmeanr* year , by(closeyear)

use "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-weighted.dta", clear
keep if sgccsd81 != . & sgccsd86 != . & sgccsd91 != . & sgccsd96 != . &sgccsd01 != . & sgccsd06 != .
drop if reopenyear != .
keep csdmetalwkwagesmeanr conscsdid year closeyear
replace closeyear = 1234 if closeyear ==.
reshape wide csdmetalwkwagesmeanr, i(conscsdid closeyear) j(year)
collapse (mean) csdmetalwkwagesmeanr*, by (closeyear)
reshape long csdmetalwkwagesmeanr, i(closeyear) j(year)
reshape wide csdmetalwkwagesmeanr, i(year) j(closeyear)
graph twoway line csdmetalwkwagesmeanr* year
graph save "P:\Liu_5114\result\labor market outcome\csdmetalwkwagesmeanr-constant8106-blur-weighted", replace


use "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-weighted.dta", clear
keep if sgccsd81 != . & sgccsd86 != . & sgccsd91 != . & sgccsd96 != . &sgccsd01 != . & sgccsd06 != .
drop if reopenyear != .
keep csdmetalwkwagesmeanr conscsdid year closeyear
replace closeyear = 1234 if closeyear ==.
sort year closeyear
seperate csdmetalwkwagesmeanr, by(conscsdid)
drop csdmetalwkwagesmeanr
count if closeyear ==1986
count if closeyear ==1991
count if closeyear ==1996
count if closeyear ==2001
count if closeyear ==2006
count if closeyear ==1234
graph twoway line csdmetalwkwagesmeanr* year if closeyear == 1986, legend(off)
graph twoway line csdmetalwkwagesmeanr* year if closeyear == 1991, legend(off)
graph twoway line csdmetalwkwagesmeanr* year if closeyear == 1996, legend(off)
graph twoway line csdmetalwkwagesmeanr* year if closeyear == 2001, legend(off)
graph twoway line csdmetalwkwagesmeanr* year if closeyear == 2006, legend(off)
graph twoway line csdmetalwkwagesmeanr* year if closeyear == 1234, legend(off)
graph twoway line csdmetalwkwagesmeanr* year , by(closeyear)


**************** Event time Analyse ***********************

clear
log using "P:\Liu_5114\log\1980-mine-CSD-changes-blur-simp-weighted.log", replace
use "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-weighted.dta", clear
keep if sgccsd81 != . & sgccsd86 != . & sgccsd91 != . & sgccsd96 != . & sgccsd01 != . & sgccsd06 != .


/*
gen closeminus3 = 1 if diffclose == -15
replace closeminus3 = 0 if closeminus3 !=1
gen closeminus2 = 1 if diffclose == -10
replace closeminus2 = 0 if closeminus2 !=1
gen closeplus3 = 1 if diffclose == 10
replace closeplus3 = 0 if closeplus3 !=1
gen closeplus2 = 1 if diffclose == 5
replace closeplus2 = 0 if closeplus2 !=1
gen closeplus1 = 1 if diffclose == 0
replace closeplus1 = 0 if closeplus1 !=1 */

global wages csdwkwages csdmetalwkwages csdselfi csdwages csdmwkwages csdfwkwages csd1525wkwages csd2535wkwages csd3545wkwages csd4555wkwages csd5565wkwages csd65wkwages csdloweduwkwages csdhischwkwages csdunivwkwages csdpubwkwages csdpvtwkwages csdpriwkwages csdsecwkwages csdterwkwages csdprifwkwages csdsecfwkwages csdterfwkwages csdprimwkwages csdsecmwkwages csdtermwkwages
global values csdvalue csdgrosrt csdtaxes
global pops csdmetalcnt csdcnt csdfcnt csdmcnt csdpricnt csdseccnt csdtercnt csdprifcnt csdprimcnt csdsecfcnt csdsecmcnt csdterfcnt csdtermcnt
global lmrates csdmetalpc csdmetalpcavail csdmetalpclbf csdmetalpcemp csdmetalpcunemp csdemprate csdempratetag csdunemprate csdunempratetag csdlfp csdlfptag csdprifmrate csdsecfmrate csdterfmrate

gen diffclose = year-closeyear
replace diffclose = . if closeyear==1234

foreach i in $wages $values {
gen ln`i'meanr = ln(`i'meanr)
gen ln`i'medianr = ln(`i'medianr)
}

foreach i in $pops {
gen ln`i' = ln(`i')
}

table diffclose, c(mean csdmetalcnt mean csdcnt mean csdmetalpc freq)
table diffclose, c(mean csdmetalpc mean csdmetalpcavail mean csdmetalpclbf mean csdmetalpcemp mean csdmetalpcunemp)
table diffclose, c(mean csdmetalwkwagesmeanr mean csdwkwagesmeanr freq)
table diffclose, c(mean lncsdmetalwkwagesmeanr mean lncsdwkwagesmeanr freq)
table diffclose, c(mean csdemprate mean csdempratetag freq)
table diffclose, c(mean csdunemprate mean csdunempratetag freq)
table diffclose, c(mean csdlfp mean csdlfptag freq)
table diffclose, c(mean lncsdvaluemeanr freq)

graph dot (mean) csdmetalcnt csdcnt, over(diffclose)
graph dot (mean) csdmetalpc csdmetalpcavail csdmetalpclbf csdmetalpcemp csdmetalpcunemp, over(diffclose)
graph dot (mean) csdmetalwkwagesmeanr csdwkwagesmeanr, over(diffclose)
graph dot (mean) lncsdmetalwkwagesmeanr lncsdwkwagesmeanr, over(diffclose)
graph dot (mean) csdemprate csdempratetag, over(diffclose)
graph dot (mean) csdunemprate csdunempratetag, over(diffclose)
graph dot (mean) csdlfp csdlfptag, over(diffclose)
graph dot (mean) lncsdvaluemeanr, over(diffclose)

gen open = year< closeyear
gen mineclose = 1-open

xi: reg mineclose i.conscsdid i.year lnmineprice, robust

replace closeyear = . if closeyear == 1234
char diffclose[omit] -5
xi i.diffclose i.conscsdid i.year i.closeyear
foreach i in $wages $values {
areg ln`i'meanr _Idiffclose* i.year,absorb(conscsdid) robust
estimates store `i'reg1
}

foreach i in $pops {
areg ln`i' _Idiffclose* i.year,absorb(conscsdid) robust
estimates store `i'reg1
}

foreach i in $lmrates {
areg `i' _Idiffclose* i.year,absorb(conscsdid) robust
estimates store `i'reg1
}

foreach i in $wages $values {
areg ln`i'meanr _Idiffclose*,absorb(conscsdid) robust
estimates store `i'reg3
}

foreach i in $pops {
areg ln`i' _Idiffclose*,absorb(conscsdid) robust
estimates store `i'reg3
}

foreach i in $lmrates {
areg `i' _Idiffclose*,absorb(conscsdid) robust
estimates store `i'reg3
}

/*
foreach i in $wages $values {
reg ln`i'meanr _Idiffclose* _Iconscsdid*, robust
estimates store `i'reg4
}

foreach i in $pops {
reg ln`i' _Idiffclose* _Iconscsdid*, robust
estimates store `i'reg4
}

foreach i in $lmrates {
reg `i' _Idiffclose* _Iconscsdid*, robust
estimates store `i'reg4
}
*/

drop if reopenyear != .
foreach i in $wages $values {
areg ln`i'meanr _Idiffclose* i.year,absorb(conscsdid) robust
estimates store `i'reg2
}

foreach i in $pops {
areg ln`i' _Idiffclose* i.year,absorb(conscsdid) robust
estimates store `i'reg2
}

foreach i in $lmrates {
areg `i' _Idiffclose* i.year,absorb(conscsdid) robust
estimates store `i'reg2
}

foreach i in $wages $values {
areg ln`i'meanr _Idiffclose*,absorb(conscsdid) robust
estimates store `i'reg4
}

foreach i in $pops {
areg ln`i' _Idiffclose*,absorb(conscsdid) robust
estimates store `i'reg4
}

foreach i in $lmrates {
areg `i' _Idiffclose*,absorb(conscsdid) robust
estimates store `i'reg4
}

estimates table *reg1, star keep(_Idiffclose*)
estimates table *reg2, star keep(_Idiffclose*)
estimates table *reg3, star keep(_Idiffclose*)
estimates table *reg4, star keep(_Idiffclose*)

areg lncsd1525wkwagesmeanr _Idiffclose* _Iyear*,absorb(conscsdid) robust
reg lncsd1525wkwagesmeanr _Idiffclose* _Icloseyear* _Iconscsdid*, robust
log close
