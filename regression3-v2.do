* Labour Markets in Resource Towns *
* Jiayi Liu *
* Created: April 2018 *

clear
log using "P:\Liu_5114\log\regression3-v2.log", replace
use "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-residual-wage-2.dta"
keep if res_in_mineCSD81 ==3 | res_in_mineCSD86 ==3 | res_in_mineCSD91 ==3 | res_in_mineCSD96 ==3 | res_in_mineCSD01 ==3 | res_in_mineCSD06 ==3
* The following table shows the CSDs with mines in 1981-2006 for one or more census years.
tab pcsd
gsort pcsd year
by pcsd: egen minecsdcnt = count(pcsd)
* The following table shows the number of years that those mining CSDs exist in 1981-2006 in terms of CSD code.
tab minecsdcnt
egen gr=group(pcsd)
sum gr

* by pcsd: gen dcsdmetalcnt = csdmetalcnt - csdmetalcnt[_n-1] if year == year[_n-1] + 5
by pcsd: gen dlncsdmetalcnt = ln(csdmetalcnt) - ln(csdmetalcnt[_n-1]) if year == year[_n-1] + 5
by pcsd: gen dlncsdcnt = ln(csdcnt) - ln(csdcnt[_n-1]) if year == year[_n-1] + 5
by pcsd: gen dlncsdindcnt = ln(csdindcnt) - ln(csdindcnt[_n-1]) if year == year[_n-1] + 5
* by pcsd: gen dcsdcnt = csdcnt - csdcnt[_n-1] if year == year[_n-1] + 5 
* by pcsd: gen dcsdindcnt = csdindcnt - csdindcnt[_n-1] if year == year[_n-1] + 5
by pcsd: gen dcsdmetalpc = csdmetalpc - csdmetalpc[_n-1] if year == year[_n-1] + 5
by pcsd: gen dcsdmetalpcavail = csdmetalpcavail - csdmetalpcavail[_n-1] if year == year[_n-1] + 5
by pcsd: gen dcsdmetalwkwagesmean = csdmetalwkwagesmean - csdmetalwkwagesmean[_n-1] if year == year[_n-1] + 5
by pcsd: gen lncsdmetalwkwagesmean = ln(csdmetalwkwagesmean)
by pcsd: gen dlncsdmetalwkwagesmean = lncsdmetalwkwagesmean - lncsdmetalwkwagesmean[_n-1] if year == year[_n-1] + 5
by pcsd: gen dlnmineprice = lnmineprice - lnmineprice[_n-1] if year == year[_n-1] + 5
regress dcsdmetalcnt dlnmineprice i.year
regress dlncsdmetalcnt dlnmineprice i.year 
regress dlncsdcnt dlnmineprice i.year 
regress dlncsdindcnt dlnmineprice i.year 
regress dcsdcnt dlnmineprice i.year  
regress dcsdindcnt dlnmineprice i.year
regress dcsdmetalwkwagesmean dlnmineprice i.year
regress dlncsdmetalwkwagesmean dlnmineprice i.year
regress dcsdmetalpc dlnmineprice i.year
regress dcsdmetalpcavail dlnmineprice i.year
regress davelwwr dlnmineprice i.year
regress davelwr dlnmineprice i.year
regress dmedlwwr dlnmineprice i.year
regress dmedlwr dlnmineprice i.year
regress davelwwr dlncsdmetalcnt i.year
regress davelwwr dcsdmetalpc i.year
regress dmedlwwr dlncsdmetalcnt i.year
regress dmedlwwr dcsdmetalpc i.year
regress dlncsdmetalcnt dlnmineprice i.year

ivregress 2sls davelwwr (dlncsdmetalcnt = dlnmineprice) i.year
ivregress 2sls davelwr (dlncsdmetalcnt = dlnmineprice) i.year
ivregress 2sls dmedlwwr (dlncsdmetalcnt = dlnmineprice) i.year
ivregress 2sls dmedlwr (dlncsdmetalcnt = dlnmineprice) i.year

ivregress 2sls dlncsdmetalwkwagesmean (dlncsdmetalcnt = dlnmineprice) i.year
ivregress 2sls davelwwr0 (dlncsdmetalcnt = dlnmineprice) i.year
ivregress 2sls davelwr0 (dlncsdmetalcnt = dlnmineprice) i.year
ivregress 2sls dmedlwwr0 (dlncsdmetalcnt = dlnmineprice) i.year
ivregress 2sls dmedlwr0 (dlncsdmetalcnt = dlnmineprice) i.year

ivregress 2sls davelwwr (dlncsdmetalcnt = dlnmineprice) i.year csdagemean
ivregress 2sls davelwr (dlncsdmetalcnt = dlnmineprice) i.year csdagemean
ivregress 2sls dmedlwwr (dlncsdmetalcnt = dlnmineprice) i.year csdagemean
ivregress 2sls dmedlwr (dlncsdmetalcnt = dlnmineprice) i.year csdagemean

ivregress 2sls davelwwr (dlncsdmetalcnt = dlnmineprice) i.year csdagemedian
ivregress 2sls davelwr (dlncsdmetalcnt = dlnmineprice) i.year csdagemedian
ivregress 2sls dmedlwwr (dlncsdmetalcnt = dlnmineprice) i.year csdagemedian
ivregress 2sls dmedlwr (dlncsdmetalcnt = dlnmineprice) i.year csdagemedian

ivregress 2sls davelwwr (dlncsdmetalcnt = dlnmineprice) i.year csdagemode
ivregress 2sls davelwr (dlncsdmetalcnt = dlnmineprice) i.year csdagemode
ivregress 2sls dmedlwwr (dlncsdmetalcnt = dlnmineprice) i.year csdagemode
ivregress 2sls dmedlwr (dlncsdmetalcnt = dlnmineprice) i.year csdagemode

ivregress 2sls davelwwr (dlncsdmetalcnt = dlnmineprice) i.year ln(csdhischcnt)
ivregress 2sls davelwr (dlncsdmetalcnt = dlnmineprice) i.year ln(csdhischcnt)
ivregress 2sls dmedlwwr (dlncsdmetalcnt = dlnmineprice) i.year ln(csdhischcnt)
ivregress 2sls dmedlwr (dlncsdmetalcnt = dlnmineprice) i.year ln(csdhischcnt)

* check why observation only have 25, some dlnmineprice doesn't have matched davelwwr
sum res_in_mineCSD86 if dmedlwr!=. & year ==1986
sum res_in_mineCSD91 if dmedlwr!=. & year ==1991
sum res_in_mineCSD96 if dmedlwr!=. & year ==1996
sum res_in_mineCSD01 if dmedlwr!=. & year ==2001
sum res_in_mineCSD06 if dmedlwr!=. & year ==2006

sum res_in_mineCSD86 if dlnmineprice!=. & year ==1986
sum res_in_mineCSD91 if dlnmineprice!=. & year ==1991
sum res_in_mineCSD96 if dlnmineprice!=. & year ==1996
sum res_in_mineCSD01 if dlnmineprice!=. & year ==2001
sum res_in_mineCSD06 if dlnmineprice!=. & year ==2006

sum res_in_mineCSD86 csdmetalcnt if dlnmineprice!=. & dmedlwr==. & year ==1986
tab pcsd if dlnmineprice!=. & dmedlwr==. & year ==1986
sum res_in_mineCSD91 csdmetalcnt if dlnmineprice!=. & dmedlwr==. & year ==1991

keep if (year == 1986 & res_in_mineCSD81 ==3 & res_in_mineCSD86 ==3) | (year == 1991 & res_in_mineCSD86 ==3 & res_in_mineCSD91 ==3) | (year == 1996 & res_in_mineCSD91 ==3 & res_in_mineCSD96 ==3) |(year == 2001 & res_in_mineCSD96 ==3 & res_in_mineCSD01 ==3) | (year == 2006 & res_in_mineCSD01 ==3 & res_in_mineCSD06 ==3)
log close
regress dcsdmetalcnt dlnmineprice i.year
regress dcsdcnt dlnmineprice i.year  
regress dcsdindcnt dlnmineprice i.year
regress dcsdmetalwkwagesmean dlnmineprice i.year
regress dlncsdmetalwkwagesmean dlnmineprice i.year
regress dcsdmetalpc dlnmineprice i.year
regress dcsdmetalpcavail dlnmineprice i.year
