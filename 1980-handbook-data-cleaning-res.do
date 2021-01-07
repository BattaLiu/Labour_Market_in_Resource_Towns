* Labour Markets in Resource Towns *
* Jiayi Liu *
* Created: Jan 2018 *

/* want to use Canadian Mines Handbook to create a price index for each mine */
clear
import delimited P:\Liu_5114\mine-handbook-1980-reserve-2.csv

/* separate quantity and unit */

gen reserve_data=1 if length(reserve)!=0
replace reserve_data = 0 if reserve_data ==.
rename gold_gradeopt gold_grade
gen gold_data=1 if length(gold_grade)!=0
replace gold_data = 0 if gold_data==.
gen silver_data=1 if length(silver_grade)!=0
replace silver_data = 0 if silver_data==.
gen copper_data=1 if length(copper_grade)!=0
replace copper_data = 0 if copper_data==.
gen zinc_data=1 if length(zinc_grade)!=0
replace zinc_data = 0 if zinc_data==.
gen lead_data=1 if length(lead_grade)!=0
replace lead_data = 0 if lead_data==.
gen nickel_data=1 if length(nickel_grade)!=0
replace nickel_data = 0 if nickel_data==.
gen uranium_data=1 if length(uranium_grade)!=0
replace uranium_data = 0 if uranium_data==.
gen molybdenum_data=1 if length(molybdenum_grade)!=0
replace molybdenum_data = 0 if molybdenum_data==.
* gen cobalt_data=1 if length(cobalt_grade)!=0
* replace cobalt_data = 0 if cobalt_data==.
gen wo3_data=1 if length(wo3_grade)!=0
replace wo3_data = 0 if wo3_data==.
gen antimony_data=1 if length(antimony_grade)!=0
replace antimony_data = 0 if antimony_data==.
* gen u3o8_data=1 if length(u3o8_grade)!=0
* replace u3o8_data = 0 if u3o8_data==.
rename niobium_grade niobium_oxide_grade
gen niobium_oxide_data=1 if length(niobium_oxide_grade)!=0
replace niobium_oxide_data = 0 if niobium_oxide_data==.
* gen tantalum_oxide_data=1 if length(tantalum_oxide_prod)!=0
* replace tantalum_oxide_data = 0 if tantalum_oxide_data==.

/* Check the existence of grade data for each mine, unfinished */
count if reserve_data ==1
count if gold_data==1 
count if silver_data==1 
count if copper_data==1 
count if zinc_data==1 
count if lead_data==1 
count if nickel_data==1 
count if uranium_data==1 
count if molybdenum_data==1 
* count if cobalt_data==1 
count if wo3_data==1 
count if antimony_data==1 
* count if u3o8_data==1 
* count if niobium_oxide_data==1 
* count if tantalum_oxide_data==1 
count if gold_data + silver_data + copper_data + zinc_data + lead_data + nickel_data + uranium_data + molybdenum_data + wo3_data + antimony_data + niobium_oxide_data>0
gen data=0 if  gold_data + silver_data + copper_data + zinc_data + lead_data + nickel_data + uranium_data + molybdenum_data + wo3_data + antimony_data + niobium_oxide_data==0
replace data =1 if data!=0

/* calculate the grades for each mine */
gen reserve_count = wordcount(reserve)
split reserve, p(" ")
tab reserve2
replace reserve2 = reserve2+" "+ reserve3 if reserve2 == "long"
replace reserve3 = "." if reserve2 == "long tons"
destring reserve1, replace
destring reserve3, replace
destring reserve5, replace
destring reserve7, replace
replace reserve3 = 0 if reserve3 == .
replace reserve5 = 0 if reserve5 == .
replace reserve7 = 0 if reserve7 == .
gen reserve1_prop = reserve1/(reserve1 + reserve3 + reserve5 + reserve7)
gen reserve3_prop = reserve3/(reserve1 + reserve3 + reserve5 + reserve7)
gen reserve5_prop = reserve5/(reserve1 + reserve3 + reserve5 + reserve7)
gen reserve7_prop = reserve7/(reserve1 + reserve3 + reserve5 + reserve7)
count if data==0 & reserve_data ==1 & reserve1 >0
replace reserve1 = reserve1* 1.12 if reserve2 == "long tons"
gen reserve_unit = word(reserve, -1)
tab reserve_unit


split gold_grade, p(" ")
replace gold_grade = rtrim(gold_grade)
gen gold_unit = word(gold_grade, -1) 
tab gold_unit  //need to check whether the units are the same under one variable
count if gold_data ==1
gen gold_count = wordcount(gold_grade)
destring gold_grade1, replace
destring gold_grade3, replace
destring gold_grade5, replace
destring gold_grade7, replace
replace gold_grade3 = 0 if gold_grade3 == .
replace gold_grade5 = 0 if gold_grade5 == .
replace gold_grade7 = 0 if gold_grade7 == .
gen gold_grade_weighed = gold_grade1 if gold_count ==2
replace gold_grade_weighed = gold_grade1*reserve1_prop + gold_grade3*reserve3_prop if gold_count ==4 
replace gold_grade_weighed = gold_grade1*reserve1_prop + gold_grade3*reserve3_prop + gold_grade5*reserve5_prop if gold_count ==6 
replace gold_grade_weighed = gold_grade1*reserve1_prop + gold_grade3*reserve3_prop + gold_grade5*reserve5_prop + gold_grade7*reserve7_prop if gold_count ==8

split silver_grade, p(" ")
replace silver_grade = rtrim(silver_grade)
gen silver_unit = word(silver_grade, -1) 
tab silver_unit //need to check whether the units are the same under one variable
count if silver_data ==1
gen silver_count = wordcount(silver_grade)
destring silver_grade1, replace
destring silver_grade3, replace
destring silver_grade5, replace
destring silver_grade7, replace
replace silver_grade3 = 0 if silver_grade3 == .
replace silver_grade5 = 0 if silver_grade5 == .
replace silver_grade7 = 0 if silver_grade7 == .
gen silver_grade_weighed = silver_grade1 if silver_count ==2
replace silver_grade_weighed = silver_grade1*reserve1_prop + silver_grade3*reserve3_prop if silver_count ==4 
replace silver_grade_weighed = silver_grade1*reserve1_prop + silver_grade3*reserve3_prop + silver_grade5*reserve5_prop + silver_grade7*reserve7_prop if silver_count ==8 
replace silver_grade_weighed = silver_grade_weighed* 0.0292 if silver_unit == "g/tonne"

* I need to check the unit for copper grade is % in 1980 minebook data
replace copper_grade = rtrim(copper_grade)
gen copper_grade_tail = substr(copper_grade, -1, 1)
tab copper_grade_tail
count if length(copper_grade)!=0
replace copper_grade = substr(copper_grade, 1, length(copper_grade)-1)
split copper_grade, p(" ")
gen copper_count = wordcount(copper_grade)
destring copper_grade1, replace
destring copper_grade3, replace
destring copper_grade5, replace
destring copper_grade7, replace
replace copper_grade3 = 0 if copper_grade3 == .
replace copper_grade5 = 0 if copper_grade5 == .
replace copper_grade7 = 0 if copper_grade7 == .
gen copper_grade_weighed = copper_grade1 if copper_count ==1
replace copper_grade_weighed = copper_grade1*reserve1_prop + copper_grade3*reserve3_prop if copper_count ==3
replace copper_grade_weighed = copper_grade1*reserve1_prop + copper_grade3*reserve3_prop + copper_grade5*reserve5_prop + copper_grade7*reserve7_prop if copper_count ==7 
count if copper_grade_weighed !=. & copper_grade_weighed >0
count if length(copper_grade)!=0

replace zinc_grade = rtrim(zinc_grade)
gen zinc_grade_tail = substr(zinc_grade, -1, 1)
tab zinc_grade_tail
count if length(zinc_grade)!=0
replace zinc_grade = substr(zinc_grade, 1, length(zinc_grade)-1)
split zinc_grade, p(" ")
gen zinc_count = wordcount(zinc_grade)
destring zinc_grade1, replace
destring zinc_grade3, replace
destring zinc_grade5, replace
destring zinc_grade7, replace
replace zinc_grade3 = 0 if zinc_grade3 == .
replace zinc_grade5 = 0 if zinc_grade5 == .
replace zinc_grade7 = 0 if zinc_grade7 == .
gen zinc_grade_weighed = zinc_grade1 if zinc_count ==1
replace zinc_grade_weighed = zinc_grade1*reserve1_prop + zinc_grade3*reserve3_prop if zinc_count ==3
replace zinc_grade_weighed = zinc_grade1*reserve1_prop + zinc_grade3*reserve3_prop + zinc_grade5*reserve5_prop + zinc_grade7*reserve7_prop if zinc_count ==7 
count if zinc_grade_weighed !=. & zinc_grade_weighed >0
count if length(zinc_grade)!=0

replace lead_grade = rtrim(lead_grade)
gen lead_grade_tail = substr(lead_grade, -1, 1)
tab lead_grade_tail 
count if length(lead_grade)!=0
replace lead_grade = substr(lead_grade, 1, length(lead_grade)-1)
split lead_grade, p(" ")
gen lead_count = wordcount(lead_grade)
destring lead_grade1, replace
destring lead_grade3, replace
replace lead_grade3 = 0 if lead_grade3 == .
gen lead_grade_weighed = lead_grade1 if lead_count ==1
replace lead_grade_weighed = lead_grade1*reserve1_prop + lead_grade3*reserve3_prop if lead_count ==3
count if lead_grade_weighed !=. & lead_grade_weighed >0
count if length(lead_grade)!=0

replace nickel_grade = rtrim(nickel_grade)
gen nickel_grade_tail = substr(nickel_grade, -1, 1)
tab nickel_grade_tail
count if length(nickel_grade)!=0
replace nickel_grade = substr(nickel_grade, 1, length(nickel_grade)-1)
split nickel_grade, p(" ")
gen nickel_count = wordcount(nickel_grade)
destring nickel_grade1, replace
gen nickel_grade_weighed = nickel_grade1 if nickel_count ==1
count if nickel_grade_weighed !=. & nickel_grade_weighed >0
count if length(nickel_grade)!=0

/* Keep mines that content only metals with World Bank price.*/
count if gold_data + silver_data + copper_data + zinc_data + lead_data + nickel_data>0
keep if gold_data + silver_data + copper_data + zinc_data + lead_data + nickel_data>0
gen metal_numb_res = gold_data + silver_data + copper_data + zinc_data + lead_data + nickel_data + uranium_data + molybdenum_data + wo3_data + antimony_data + niobium_oxide_data
gen trim_numb_res = gold_data + silver_data + copper_data + zinc_data + lead_data + nickel_data
keep if trim_numb_res == metal_numb_res & trim_numb_res>0
keep province company minesite location *_weighed trim_numb_res
save "P:\Liu_5114\result\handbook-data\1980-res-trimmed", replace
merge 1:1 province company minesite location using"P:\Liu_5114\result\handbook-data\1980-prod-trimmed"
export delimited using "P:\Liu_5114\result\handbook-data\1980-trimmed", replace

/* Next step is to match the "P:\Liu_5114\result\handbook-data\1980-trimmed" file with World bank price data
/* Next R file is "P:\Liu_5114\code\R\price-index.R"




