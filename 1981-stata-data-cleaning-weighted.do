* Labour Markets in Resource Towns *
* Jiayi Liu *
* Created: May 2017 *
* Last update: Jan 2018*

/* Summarize the labour market outcomes for each CSD */

* used variables: industry, pcsd, pow, wages, weeks, age, hgradr, ps_otr, ps_uvr, hlos, dgreer
clear 
log using "P:\Liu_5114\log\1981-stata-data-cleaning-weighted.log", replace
use "P:\Liu_5114\data\1981.dta"
/* Calculate the percentage of people working in industry metal (metal mines),
compared total population */
gen indmetal = 1 if industry>= 22 & industry <28
replace indmetal = 0 if industry <22 | industry >=28

gen hmain1 = 1 if hmain == 3
replace hmain1 = 0 if hmain !=3
gen owner = 1 if hmain ==3 & value>0
replace owner = 0 if owner !=1
/* sum csdmetalpc
sum csdmetalpc, detail
count if csdmetalpc>0 */

/* Calculate the percentage of people working in industry metal (metal mines), 
compared to total working population*/ 
gen indavail = 1 if industry != 330
replace indavail = 0 if industry ==330

gen workpop = 1 if lf71 >0
gen lbf = 1 if lf71 > 0 & lf71 != 6 & lf71 != 7
gen emp = 1 if lf71 >0 & lf71 < 6
gen unemp = 1 if lf71 > 7 & lf71 <=10

gen workpoptag = 1 if lftag <22
gen lbftag = 1 if lftag < 18
gen emptag = 1 if lftag < 5
gen unemptag = 1 if lftag >=5 & lftag <18

gen lbfmetal = 1 if indmetal == 1 & lbf ==1
gen empmetal = 1 if indmetal == 1 & emp ==1
gen unempmetal = 1 if indmetal == 1 & unemp ==1

gen lbftagmetal = 1 if indmetal == 1 & lbftag ==1
gen emptagmetal = 1 if indmetal == 1 & emptag ==1
gen unemptagmetal = 1 if indmetal == 1 & unemptag ==1

/* Calculate the percentage of people wages from mining industry metal */
gen indmetalwages = wages if indmetal ==1
replace indmetalwages = 0 if indmetal ==0

gen wkwages = wages/weeks if weeks >0 & wages > 0
gen wkindmetalwages = wkwages if indmetal ==1

/* by pcsd, sort: egen csdwkwagesmean = mean(wkwages)
by pcsd, sort: egen csdwkwagesmedian = median(wkwages)
by pcsd, sort: egen csdwkwagesmode = mode(wkwages)
by pcsd, sort: egen csdmetalwkwagesmean = mean(wkindmetalwages)
by pcsd, sort: egen csdmetalwkwagesmedian = median(wkindmetalwages)
by pcsd, sort: egen csdmetalwkwagesmode = mode(wkindmetalwages)
by pcsd, sort: egen csdtotincmean = mean(totinc) if  totinc!=0
by pcsd, sort: egen csdtotincmedian = median(totinc) if  totinc!=0
by pcsd, sort: egen csdtotincmode = mode(totinc) if  totinc!=0
by pcsd, sort: egen csdselfimean = mean(selfi) if selfi!=0
by pcsd, sort: egen csdselfimedian = median(selfi) if selfi!=0
by pcsd, sort: egen csdselfimode = mode(selfi) if selfi!=0
by pcsd, sort: egen csdwagesmean = mean(wages) if wages>0
by pcsd, sort: egen csdwagesmedian = median(wages) if wages>0
by pcsd, sort: egen csdwagesmode = mode(wages) if wages>0 
by pcsd, sort: egen csdwkwagesmode = mode(wkwages)
by pcsd, sort: egen csdmetalwkwagesmode = mode(wkindmetalwages)
by pcsd, sort: egen csdtotincmode = mode(totinc) if  totinc!=0
by pcsd, sort: egen csdselfimode = mode(selfi) if selfi!=0
by pcsd, sort: egen csdwagesmode = mode(wages) if wages>0 */
gen totinc1 = totinc if totinc != 0
gen selfi1 = selfi if selfi != 0
gen wages1 = wages if wages >0

/*gen csdmine=1 if csdmetalincpc>=csdmetalpc & csdmetalincpc!= 0 & csdmetalpc !=0
replace csdmine = 0 if csdmine == .
count if indmetal>0 */

/* list CSDs with high mining population and high mining income
list pcsd csdmetalincpc csdmetalpc if csdmetalincpc>0.02 & csdmetalpc > 0.02
gsort -csdmetalincpc -csdmetalpc pcsd 
* pctile pctest= csdmetalpc, nq(1000)
* list pctest in 1/10 */

/* Check the average schooling in different CSDs*/
gen hgrady = 1 if hgradr ==6
replace hgrady = 2 if hgradr ==13
replace hgrady = 3 if hgradr ==11
replace hgrady = 4 if hgradr ==14
replace hgrady = 5 if hgradr ==3
replace hgrady = 6 if hgradr ==8
replace hgrady = 7 if hgradr ==7
replace hgrady = 8 if hgradr ==1
replace hgrady = 9 if hgradr ==5
replace hgrady = 10 if hgradr ==9
replace hgrady = 11 if hgradr ==2
replace hgrady = 12 if hgradr ==12
replace hgrady = 13 if hgradr ==10
replace hgrady = 0 if hgradr ==14

gen ps_oty = 4 if ps_otr ==1
replace ps_oty = 0.5 if ps_otr ==2
replace ps_oty = 0 if ps_otr ==3
replace ps_oty = . if ps_otr ==4
replace ps_oty = 1 if ps_otr ==5
replace ps_oty = 3 if ps_otr ==6
replace ps_oty = 2 if ps_otr ==7


gen ps_uvy = 8 if ps_uvr ==1
replace ps_uvy = 11 if ps_uvr ==2
replace ps_uvy = 5 if ps_uvr ==3
replace ps_uvy = 4 if ps_uvr ==4
replace ps_uvy = 0.5 if ps_uvr ==5
replace ps_uvy = 9 if ps_uvr ==6
replace ps_uvy = 0 if ps_uvr ==7
replace ps_uvy = . if ps_uvr ==8
replace ps_uvy = 1 if ps_uvr ==9
replace ps_uvy = 7 if ps_uvr ==10
replace ps_uvy = 6 if ps_uvr ==11
replace ps_uvy = 10 if ps_uvr ==12
replace ps_uvy = 3 if ps_uvr ==13
replace ps_uvy = 2 if ps_uvr ==14


/*
gen csdschyear = hgrady if hlos <5 & hlos > 0 
replace csdschyear = hgrady + ps_oty if hlos >5 & hlos<9
replace csdschyear = hgradr if hlos ==9
replace csdschyaer = ps_uvr if hlos >10*/

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

/* check the mobility of residence and work(if applicable)*/
/* 
count if indmetal ==1 & pow == pcsd
by pow, sort: egen powmetalcnt = total(indmetal)
by pow, sort: egen powcnt = count(pow)
gen powmetalpc = powmetalcnt/powcnt

by pow, sort: egen powindcnt = total(indavail)
gen powmetalpcavail = powmetalcnt/powindcnt */

gen diffcsd5 = 1 if mob5 == 2 | mob5 == 3
replace diffcsd5 = 0 if mob5 == 4 | mob5 ==5

/* check the housing price of each CSD */
/*
by pcsd, sort: egen csdvaluemean = mean(value) if hmain==3 & value>0
by pcsd, sort: egen csdvaluemedian = median(value) if hmain==3 & value>0
by pcsd, sort: egen csdvaluemode = mode(value) if hmain==3 & value>0
by pcsd, sort: egen csdgrosrtmean = mean(grosrt) if hmain==3 & grosrt>=0
by pcsd, sort: egen csdgrosrtmedian = median(grosrt) if hmain==3 & grosrt>=0
by pcsd, sort: egen csdgrosrtmode = mode(grosrt) if hmain==3 & grosrt>=0
by pcsd, sort: egen csdtaxesmean = mean(taxes) if hmain==3 & taxes>=0
by pcsd, sort: egen csdtaxesmedian = median(taxes) if hmain==3 & taxes>=0
by pcsd, sort: egen csdtaxesmode = mode(taxes) if hmain==3 & taxes>=0
*/
gen value1 = value if hmain ==3 & value>0
gen grosrt1 = grosrt if hmain ==3 & grosrt>=0
gen taxes1 = taxes if hmain ==3 & taxes>=0

/* compare the different definition of obs, unfinished*/
count if indmetal ==1

// income of different groups
gen loweduwkwages = wkwages if csdlow ==1
gen hischwkwages = wkwages if csdhisch ==1
gen univwkwages = wkwages if csduniv ==1

gen age14 = 1 if age <15
gen age1525 = 1 if age>=15 & age <25
gen age2535 = 1 if age>=25 & age <35
gen age3545 = 1 if age>=35 & age <45
gen age4555 = 1 if age>=45 & age <55
gen age5565 = 1 if age>=55 & age <65
gen age65 = 1 if age >=65

gen fwkwages = wkwages if sex == 1
gen mwkwages = wkwages if sex == 2

gen wkwages1525 = wkwages if age>=15 & age <25
gen wkwages2535 = wkwages if age>=25 & age <35
gen wkwages3545 = wkwages if age>=35 & age <45
gen wkwages4555 = wkwages if age>=45 & age <55
gen wkwages5565 = wkwages if age>=55 & age <65
gen wkwages65 = wkwages if age >=65

gen pubsec = 1 if (industry > 260 & industry < 279) | (industry>320 & industry<330)
gen pvtsec = 1 if pubsec !=1 & industry != 330 
gen pubwkwages = wkwages if pubsec == 1
gen pvtwkwages = wkwages if pvtsec == 1

gen prisec = 1 if industry >0 & industry <43
gen secsec = 1 if industry >42 & industry <181
gen tersec = 1 if industry >180 & industry <330

gen priwkwages = wkwages if prisec ==1
gen secwkwages = wkwages if secsec ==1
gen terwkwages = wkwages if tersec ==1

gen female = 1 if sex == 1
gen male = 1 if sex == 2

gen prifemale = 1 if female == 1 & prisec == 1
gen primale = 1 if male == 1 & prisec == 1
gen secfemale = 1 if female == 1 & secsec == 1
gen secmale = 1 if male == 1 & secsec == 1
gen terfemale = 1 if female == 1 & tersec == 1
gen termale = 1 if male == 1 & tersec == 1

gen prifwkwages = wkwages if female == 1 & prisec == 1
gen primwkwages = wkwages if male == 1 & prisec == 1
gen secfwkwages = wkwages if female == 1 & secsec == 1
gen secmwkwages = wkwages if male == 1 & secsec == 1
gen terfwkwages = wkwages if female == 1 & tersec == 1
gen termwkwages = wkwages if male == 1 & tersec == 1
// collapse (sum) csdmetalcnt = indmetal csdhmaincnt = hmain1 csdownercnt = owner csdindcnt = indavail csdworkpop = workpop csdlbfcnt = lbf csdempcnt = emp csdunempcnt = unemp csdworkpoptag = workpoptag csdlbftagcnt = lbftag csdemptagcnt = emptag csdunemptagcnt = unemptag lbfmetalcnt = lbfmetal empmetalcnt = empmetal unempmetalcnt = unempmetal lbftagmetalcnt = lbftagmetal emptagmetalcnt = emptagmetal unemptagmetalcnt = unemptagmetal csdtotwages = wages csdmetaltotwages = indmetalwages csdhischcnt = csdhisch csdunivcnt = csduniv csdlowcnt = csdlow csd15cnt = csd15 diffcsd5cnt = diffcsd5 csdcnt14 = age14 csdcnt1525 = age1525 csdcnt2535 = age2535 csdcnt3545 = age3545 csdcnt4555 = age4555 csdcnt5565 = age5565 csdcnt65 = age65 (count) csdcnt= age (mean) cma = cma csdwkwagesmean = wkwages csdmetalwkwagesmean = wkindmetalwages csdtotincmean = totinc1 csdselfimean = selfi1 csdwagesmean = wages1 csdagemean = age csdvaluemean = value1 csdgrosrtmean = grosrt1 csdtaxesmean = taxes1 csdfwkwagesmean = fwkwages csdmwkwagesmean = mwkwages csd1525wkwagesmean = wkwages1525 csd2535wkwagesmean = wkwages2535 csd3545wkwagesmean = wkwages3545 csd4555wkwagesmean = wkwages4555 csd5565wkwagesmean = wkwages5565 csd65wkwagesmean = wkwages65 csdloweduwkwagesmean = loweduwkwages csdhischwkwagesmean = hischwkwages csdunivwkwagesmean = univwkwages csdpubwkwagesmean = pubwkwages csdpvtwkwagesmean = pvtwkwages (median) csdwkwagesmedian = wkwages csdmetalwkwagesmedian = wkindmetalwages csdtotincmedian = totinc1 csdselfimedian = selfi1 csdwagesmedian = wages1 csdagemedian = age csdvaluemedian = value1 csdgrosrtmedian = grosrt1 csdtaxesmedian = taxes1 csdfwkwagesmedian = fwkwages csdmwkwagesmedian = mwkwages csd1525wkwagesmedian = wkwages1525 csd2535wkwagesmedian = wkwages2535 csd3545wkwagesmedian = wkwages3545 csd4555wkwagesmedian = wkwages4555 csd5565wkwagesmedian = wkwages5565 csd65wkwagesmedian = wkwages65 csdloweduwkwagesmedian = loweduwkwages csdhischwkwagesmedian = hischwkwages csdunivwkwagesmedian = univwkwages csdpubwkwagesmedian = pubwkwages csdpvtwkwagesmedian = pvtwkwages [pw = compw5], by(pcsd)
collapse (sum) csdmetalcnt = indmetal csdhmaincnt = hmain1 csdownercnt = owner csdindcnt = indavail csdworkpop = workpop csdlbfcnt = lbf csdempcnt = emp csdunempcnt = unemp csdworkpoptag = workpoptag csdlbftagcnt = lbftag csdemptagcnt = emptag csdunemptagcnt = unemptag lbfmetalcnt = lbfmetal empmetalcnt = empmetal unempmetalcnt = unempmetal lbftagmetalcnt = lbftagmetal emptagmetalcnt = emptagmetal unemptagmetalcnt = unemptagmetal csdtotwages = wages csdmetaltotwages = indmetalwages csdhischcnt = csdhisch csdunivcnt = csduniv csdlowcnt = csdlow csd15cnt = csd15 diffcsd5cnt = diffcsd5 csdcnt14 = age14 csdcnt1525 = age1525 csdcnt2535 = age2535 csdcnt3545 = age3545 csdcnt4555 = age4555 csdcnt5565 = age5565 csdcnt65 = age65 csdpubcnt = pubsec csdpvtcnt = pvtsec csdpricnt = prisec csdseccnt = secsec csdtercnt = tersec csdfcnt = female csdmcnt = male csdprifcnt = prifemale csdprimcnt = primale csdsecfcnt = secfemale csdsecmcnt = secmale csdterfcnt = terfemale csdtermcnt = termale (count) csdcnt= age (mean) cma = cma csdwkwagesmean = wkwages csdmetalwkwagesmean = wkindmetalwages csdtotincmean = totinc1 csdselfimean = selfi1 csdwagesmean = wages1 csdagemean = age csdvaluemean = value1 csdgrosrtmean = grosrt1 csdtaxesmean = taxes1 csdfwkwagesmean = fwkwages csdmwkwagesmean = mwkwages csd1525wkwagesmean = wkwages1525 csd2535wkwagesmean = wkwages2535 csd3545wkwagesmean = wkwages3545 csd4555wkwagesmean = wkwages4555 csd5565wkwagesmean = wkwages5565 csd65wkwagesmean = wkwages65 csdloweduwkwagesmean = loweduwkwages csdhischwkwagesmean = hischwkwages csdunivwkwagesmean = univwkwages csdpubwkwagesmean = pubwkwages csdpvtwkwagesmean = pvtwkwages csdpriwkwagesmean = priwkwages csdprifwkwagesmean = prifwkwages csdprimwkwagesmean = primwkwages csdsecwkwagesmean = secwkwages csdsecfwkwagesmean = secfwkwages csdsecmwkwagesmean = secmwkwages csdterwkwagesmean = terwkwages csdterfwkwagesmean = terfwkwages csdtermwkwagesmean = termwkwages (median) csdwkwagesmedian = wkwages csdmetalwkwagesmedian = wkindmetalwages csdtotincmedian = totinc1 csdselfimedian = selfi1 csdwagesmedian = wages1 csdagemedian = age csdvaluemedian = value1 csdgrosrtmedian = grosrt1 csdtaxesmedian = taxes1 csdfwkwagesmedian = fwkwages csdmwkwagesmedian = mwkwages csd1525wkwagesmedian = wkwages1525 csd2535wkwagesmedian = wkwages2535 csd3545wkwagesmedian = wkwages3545 csd4555wkwagesmedian = wkwages4555 csd5565wkwagesmedian = wkwages5565 csd65wkwagesmedian = wkwages65 csdloweduwkwagesmedian = loweduwkwages csdhischwkwagesmedian = hischwkwages csdunivwkwagesmedian = univwkwages csdpubwkwagesmedian = pubwkwages csdpvtwkwagesmedian = pvtwkwages csdpriwkwagesmedian = priwkwages csdprifwkwagesmedian = prifwkwages csdprimwkwagesmedian = primwkwages csdsecwkwagesmedian = secwkwages csdsecfwkwagesmedian = secfwkwages csdsecmwkwagesmedian = secmwkwages csdterwkwagesmedian = terwkwages csdterfwkwagesmedian = terfwkwages csdtermwkwagesmedian = termwkwages [pw = compw5], by(pcsd)

/* inflation adjustment */
scalar cpi2002 = 44

// incomes
gen csdwkwagesmeanr = csdwkwagesmean*100/cpi2002
gen csdwkwagesmedianr = csdwkwagesmedian*100/cpi2002

gen csdmetalwkwagesmeanr = csdmetalwkwagesmean*100/cpi2002
gen csdmetalwkwagesmedianr = csdmetalwkwagesmedian*100/cpi2002

gen csdtotincmeanr = csdtotincmean*100/cpi2002
gen csdtotincmedianr = csdtotincmedian*100/cpi2002

gen csdselfimeanr = csdselfimean*100/cpi2002
gen csdselfimedianr = csdselfimedian*100/cpi2002

gen csdwagesmeanr = csdwagesmean*100/cpi2002
gen csdwagesmedianr = csdwagesmedian*100/cpi2002

// cost
gen csdvaluemeanr = csdvaluemean*100/cpi2002
gen csdvaluemedianr = csdvaluemedian*100/cpi2002

gen csdgrosrtmeanr = csdgrosrtmean*100/cpi2002
gen csdgrosrtmedianr = csdgrosrtmedian*100/cpi2002

gen csdtaxesmeanr = csdtaxesmean*100/cpi2002
gen csdtaxesmedianr = csdtaxesmedian*100/cpi2002

// income of different groups
gen csdfwkwagesmeanr = csdfwkwagesmean*100/cpi2002
gen csdmwkwagesmeanr = csdmwkwagesmean*100/cpi2002
gen csd1525wkwagesmeanr = csd1525wkwagesmean*100/cpi2002
gen csd2535wkwagesmeanr = csd2535wkwagesmean*100/cpi2002
gen csd3545wkwagesmeanr = csd3545wkwagesmean*100/cpi2002
gen csd4555wkwagesmeanr = csd4555wkwagesmean*100/cpi2002
gen csd5565wkwagesmeanr = csd5565wkwagesmean*100/cpi2002
gen csd65wkwagesmeanr = csd65wkwagesmean*100/cpi2002
gen csdloweduwkwagesmeanr = csdloweduwkwagesmean*100/cpi2002
gen csdhischwkwagesmeanr = csdhischwkwagesmean*100/cpi2002
gen csdunivwkwagesmeanr = csdunivwkwagesmean*100/cpi2002
gen csdpubwkwagesmeanr = csdpubwkwagesmean*100/cpi2002
gen csdpvtwkwagesmeanr = csdpvtwkwagesmean*100/cpi2002
gen csdpriwkwagesmeanr = csdpriwkwagesmean*100/cpi2002
gen csdsecwkwagesmeanr = csdsecwkwagesmean*100/cpi2002
gen csdterwkwagesmeanr = csdterwkwagesmean*100/cpi2002
gen csdprifwkwagesmeanr = csdprifwkwagesmean*100/cpi2002
gen csdsecfwkwagesmeanr = csdsecfwkwagesmean*100/cpi2002
gen csdterfwkwagesmeanr = csdterfwkwagesmean*100/cpi2002
gen csdprimwkwagesmeanr = csdprimwkwagesmean*100/cpi2002
gen csdsecmwkwagesmeanr = csdsecmwkwagesmean*100/cpi2002
gen csdtermwkwagesmeanr = csdtermwkwagesmean*100/cpi2002

gen csdfwkwagesmedianr = csdfwkwagesmedian*100/cpi2002
gen csdmwkwagesmedianr = csdmwkwagesmedian*100/cpi2002
gen csd1525wkwagesmedianr = csd1525wkwagesmedian*100/cpi2002
gen csd2535wkwagesmedianr = csd2535wkwagesmedian*100/cpi2002
gen csd3545wkwagesmedianr = csd3545wkwagesmedian*100/cpi2002
gen csd4555wkwagesmedianr = csd4555wkwagesmedian*100/cpi2002
gen csd5565wkwagesmedianr = csd5565wkwagesmedian*100/cpi2002
gen csd65wkwagesmedianr = csd65wkwagesmedian*100/cpi2002
gen csdloweduwkwagesmedianr = csdloweduwkwagesmedian*100/cpi2002
gen csdhischwkwagesmedianr = csdhischwkwagesmedian*100/cpi2002
gen csdunivwkwagesmedianr = csdunivwkwagesmedian*100/cpi2002
gen csdpubwkwagesmedianr = csdpubwkwagesmedian*100/cpi2002
gen csdpvtwkwagesmedianr = csdpvtwkwagesmedian*100/cpi2002
gen csdpriwkwagesmedianr = csdpriwkwagesmedian*100/cpi2002
gen csdsecwkwagesmedianr = csdsecwkwagesmedian*100/cpi2002
gen csdterwkwagesmedianr = csdterwkwagesmedian*100/cpi2002
gen csdprifwkwagesmedianr = csdprifwkwagesmedian*100/cpi2002
gen csdsecfwkwagesmedianr = csdsecfwkwagesmedian*100/cpi2002
gen csdterfwkwagesmedianr = csdterfwkwagesmedian*100/cpi2002
gen csdprimwkwagesmedianr = csdprimwkwagesmedian*100/cpi2002
gen csdsecmwkwagesmedianr = csdsecmwkwagesmedian*100/cpi2002
gen csdtermwkwagesmedianr = csdtermwkwagesmedian*100/cpi2002

gen csdmetalpc = csdmetalcnt/csdcnt
gen csdownerpc = csdownercnt/csdhmaincnt
gen csdmetalpcavail = csdmetalcnt/csdindcnt
gen csdmetalpclbf = lbfmetalcnt/csdlbfcnt
gen csdmetalpcemp = empmetalcnt/csdempcnt
gen csdmetalpcunemp = unempmetalcnt/csdunempcnt
gen csdmetalpclbftag = lbftagmetalcnt/csdlbftagcnt
gen csdmetalpcemptag = emptagmetalcnt/csdemptagcnt
gen csdmetalpcunemptag = unemptagmetalcnt/csdunemptagcnt
gen csdlfp = csdlbfcnt/csdworkpop
gen csdemprate = csdempcnt/csdlbfcnt
gen csdunemprate = csdunempcnt/csdlbfcnt
gen csdlfptag = csdlbftagcnt/csdworkpoptag
gen csdempratetag = csdemptagcnt/csdlbftagcnt
gen csdunempratetag = csdunemptagcnt/csdlbftagcnt
gen csdprifmrate = csdprifcnt/csdprimcnt
gen csdsecfmrate = csdsecfcnt/csdsecmcnt
gen csdterfmrate = csdterfcnt/csdtermcnt

gen csdmetalwagespc = csdmetaltotwages/csdtotwages

gen csdhischpc = csdhischcnt/csd15cnt 
gen csdunivpc = csdunivcnt/csd15cnt
gen csdlowpc = csdlowcnt/csd15cnt
gen csddgreepc = (csdhischcnt + csdunivcnt)/csd15cnt


gsort pcsd
gen year = 1981
save "P:\Liu_5114\result\labor market outcome\1981-labor-outcome-weighted-compw5-test.dta", replace 
log close
