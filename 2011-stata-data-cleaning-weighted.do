* Labour Markets in Resource Towns *
* Jiayi Liu *
* Created: Sept 2018 *
* Last update: Sept 2018*

* used variables: industry, pcsd, pow, wages, weeks, age, hgradr, ps_otr, ps_uvr, hlos, dgreer
clear 
log using "P:\Liu_5114\log\2011-stata-data-cleaning-weighted.log", replace
use "P:\Liu_5114\data\NHS_2011_F1_v2.dta"
rename pwsgc pow
/* check the percentage of people working in industry 11 (metal ore mining) */
gen indmetal = 1 if naics2007 == 2122
replace indmetal = 0 if naics2007!= 2122
gen hmain1 = 1 if hmain == 1
replace hmain1 = 0 if hmain !=1
gen owner = 1 if hmain ==1 & value>0
replace owner = 0 if owner !=1

/* Calculate the percentage of people working in industry metal (metal mines), 
compared to total working population*/ 
gen indavail = 1 if naics2007 >0
replace indavail = 0 if naics2007 <0

gen workpop = 1 if lf71 >0
gen lbf = 1 if lf71 > 0 & lf71 != 6 & lf71 != 7
gen emp = 1 if lf71 >0 & lf71 < 6
gen unemp = 1 if lf71 > 7 & lf71 <= 11

gen workpoptag = 1 if lftag >0
gen lbftag = 1 if lftag >0 & lftag < 18
gen emptag = 1 if lftag >0 & lftag < 5
gen unemptag = 1 if lftag >=5 & lftag <18

gen lbfmetal = 1 if indmetal == 1 & lbf ==1
gen empmetal = 1 if indmetal == 1 & emp ==1
gen unempmetal = 1 if indmetal == 1 & unemp ==1

gen lbftagmetal = 1 if indmetal == 1 & lbftag ==1
gen emptagmetal = 1 if indmetal == 1 & emptag ==1
gen unemptagmetal = 1 if indmetal == 1 & unemptag ==1
/* Check the percentage of income from mining industry metal */
gen indmetalwages = wages if indmetal ==1
replace indmetalwages = 0 if indmetal ==0

gen wkwages = wages/weeks if weeks >0 & wages > 0
gen wkindmetalwages = wkwages if indmetal ==1

gen totinc1 = totinc if totinc != 0
gen selfi1 = selfi if selfi != 0
gen wages1 = wages if wages >0

gen degree = 1 if hcdd == 2
replace degree = 1.5 if hcdd >2 & hcdd <9
replace degree = 2 if hcdd ==9
replace degree = 2.5 if hcdd >9 & hcdd <12
replace degree = 3 if hcdd ==12
replace degree = 4 if hcdd == 13
replace degree = 0 if hcdd == 1
replace degree = . if hcdd == -3

gen csdhisch = 1 if degree==1 |degree==1.5
gen csduniv = 1 if degree>1.5 & degree!=.
gen csdlow =1 if degree<1 & degree!=.
gen csd15 = 1 if age >14 

gen diffcsd1 = 1 if mob1 == 2 | mob1 == 3
replace diffcsd1 = 0 if mob1 == 4 | mob1 ==5

gen diffcsd5 = 1 if mob5 == 2 | mob5 == 3
replace diffcsd5 = 0 if mob5 == 4 | mob5 ==5

gen value1 = value if hmain ==3 & value>0
gen grosrt1 = grosrt if hmain ==3 & grosrt>=0
gen taxes1 = taxes if hmain ==3 & taxes>=0

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

gen pubsec = 1 if naics07s == 61 | naics07s == 62 | naics07s == 91
gen pvtsec = 1 if pubsec !=1 & naics07s >0 
gen pubwkwages = wkwages if pubsec == 1
gen pvtwkwages = wkwages if pvtsec == 1

gen prisec = 1 if naics07s == 11 | naics07s == 21
gen secsec = 1 if naics07s == 22 | naics07s == 23 | naics07s == 31
gen tersec = 1 if naics07s > 31

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

collapse (sum) csdmetalcnt = indmetal csdhmaincnt = hmain1 csdownercnt = owner csdindcnt = indavail csdworkpop = workpop csdlbfcnt = lbf csdempcnt = emp csdunempcnt = unemp csdworkpoptag = workpoptag csdlbftagcnt = lbftag csdemptagcnt = emptag csdunemptagcnt = unemptag lbfmetalcnt = lbfmetal empmetalcnt = empmetal unempmetalcnt = unempmetal lbftagmetalcnt = lbftagmetal emptagmetalcnt = emptagmetal unemptagmetalcnt = unemptagmetal csdtotwages = wages csdmetaltotwages = indmetalwages csdhischcnt = csdhisch csdunivcnt = csduniv csdlowcnt = csdlow csd15cnt = csd15 diffcsd5cnt = diffcsd5 csdcnt14 = age14 csdcnt1525 = age1525 csdcnt2535 = age2535 csdcnt3545 = age3545 csdcnt4555 = age4555 csdcnt5565 = age5565 csdcnt65 = age65 csdpubcnt = pubsec csdpvtcnt = pvtsec csdpricnt = prisec csdseccnt = secsec csdtercnt = tersec csdfcnt = female csdmcnt = male csdprifcnt = prifemale csdprimcnt = primale csdsecfcnt = secfemale csdsecmcnt = secmale csdterfcnt = terfemale csdtermcnt = termale (count) csdcnt= age (mean) cma = cma csdwkwagesmean = wkwages csdmetalwkwagesmean = wkindmetalwages csdtotincmean = totinc1 csdselfimean = selfi1 csdwagesmean = wages1 csdagemean = age csdvaluemean = value1 csdgrosrtmean = grosrt1 csdtaxesmean = taxes1 csdfwkwagesmean = fwkwages csdmwkwagesmean = mwkwages csd1525wkwagesmean = wkwages1525 csd2535wkwagesmean = wkwages2535 csd3545wkwagesmean = wkwages3545 csd4555wkwagesmean = wkwages4555 csd5565wkwagesmean = wkwages5565 csd65wkwagesmean = wkwages65 csdloweduwkwagesmean = loweduwkwages csdhischwkwagesmean = hischwkwages csdunivwkwagesmean = univwkwages csdpubwkwagesmean = pubwkwages csdpvtwkwagesmean = pvtwkwages csdpriwkwagesmean = priwkwages csdprifwkwagesmean = prifwkwages csdprimwkwagesmean = primwkwages csdsecwkwagesmean = secwkwages csdsecfwkwagesmean = secfwkwages csdsecmwkwagesmean = secmwkwages csdterwkwagesmean = terwkwages csdterfwkwagesmean = terfwkwages csdtermwkwagesmean = termwkwages (median) csdwkwagesmedian = wkwages csdmetalwkwagesmedian = wkindmetalwages csdtotincmedian = totinc1 csdselfimedian = selfi1 csdwagesmedian = wages1 csdagemedian = age csdvaluemedian = value1 csdgrosrtmedian = grosrt1 csdtaxesmedian = taxes1 csdfwkwagesmedian = fwkwages csdmwkwagesmedian = mwkwages csd1525wkwagesmedian = wkwages1525 csd2535wkwagesmedian = wkwages2535 csd3545wkwagesmedian = wkwages3545 csd4555wkwagesmedian = wkwages4555 csd5565wkwagesmedian = wkwages5565 csd65wkwagesmedian = wkwages65 csdloweduwkwagesmedian = loweduwkwages csdhischwkwagesmedian = hischwkwages csdunivwkwagesmedian = univwkwages csdpubwkwagesmedian = pubwkwages csdpvtwkwagesmedian = pvtwkwages csdpriwkwagesmedian = priwkwages csdprifwkwagesmedian = prifwkwages csdprimwkwagesmedian = primwkwages csdsecwkwagesmedian = secwkwages csdsecfwkwagesmedian = secfwkwages csdsecmwkwagesmedian = secmwkwages csdterwkwagesmedian = terwkwages csdterfwkwagesmedian = terfwkwages csdtermwkwagesmedian = termwkwages [pw = compw2], by(pcsd)

/* inflation adjustment */
scalar cpi2002 = 116.5

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
gen year = 2011
save "P:\Liu_5114\result\labor market outcome\2011-labor-outcome-weighted-compw2-test.dta", replace
log close
