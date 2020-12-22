* Labour Markets in Resource Towns *
* Jiayi Liu *
* Created: Jan 2018 *

/* want to use Canadian Mines Handbook to create a price index for each mine */
clear
import delimited P:\Liu_5114\mine-handbook-1980-prod-2.csv

/* separate quantity and unit */

gen ore_milled_data=1 if length(ore_milled)!=0
replace ore_milled_data = 0 if ore_milled_data==.
rename gold_gradeopt gold_grade
gen gold_data=1 if length(gold_prod)!=0 | length(gold_grade)!=0
replace gold_data = 0 if gold_data==.
gen silver_data=1 if length(silver_prod)!=0 | length(silver_grade)!=0
replace silver_data = 0 if silver_data==.
gen copper_data=1 if length(copper_prod)!=0 | length(copper_grade)!=0
replace copper_data = 0 if copper_data==.
gen zinc_data=1 if length(zinc_prod)!=0 | length(zinc_grade)!=0
replace zinc_data = 0 if zinc_data==.
gen lead_data=1 if length(lead_prod)!=0 | length(lead_grade)!=0
replace lead_data = 0 if lead_data==.
* gen nickel_data=1 if length(nickel_grade)!=0
* replace nickel_data = 0 if nickel_data==.
gen uranium_data=1 if length(uranium_prod)!=0
replace uranium_data = 0 if uranium_data==.
gen molybdenum_data=1 if length(molybdenum_prod)!=0 | length(molybdenum_grade)!=0
replace molybdenum_data = 0 if molybdenum_data==.
gen cobalt_data=1 if length(cobalt_prod)!=0
replace cobalt_data = 0 if cobalt_data==.
gen wo3_data=1 if length(wo3_prod)!=0 | length(wo3_grade)!=0
replace wo3_data = 0 if wo3_data==.
gen antimony_data=1 if length(antimony_prod)!=0 | length(antimony_grade)!=0
replace antimony_data = 0 if antimony_data==.
gen u3o8_data=1 if length(u3o8_prod)!=0 | length(u3o8_grade)!=0
replace u3o8_data = 0 if u3o8_data==.
rename niobium_grade niobium_oxide_grade
gen niobium_oxide_data=1 if length(niobium_oxide_prod)!=0
replace niobium_oxide_data = 0 if niobium_oxide_data==.
gen tantalum_oxide_data=1 if length(tantalum_oxide_prod)!=0
replace tantalum_oxide_data = 0 if tantalum_oxide_data==.

/* Check the existence of grade data for each mine*/
split ore_milled, p(" ")
replace ore_milled2=ore_milled4 if ore_milled2=="+"
tab ore_milled2
count if ore_milled_data==1
count if gold_data==1 
count if silver_data==1 
count if copper_data==1 
count if zinc_data==1 
count if lead_data==1 
* count if nickel_data==1 
count if uranium_data==1 
count if molybdenum_data==1 
count if cobalt_data==1 
count if wo3_data==1 
count if antimony_data==1 
count if u3o8_data==1 
count if niobium_oxide_data==1 
* count if tantalum_oxide_data==1 
count if gold_data + silver_data + copper_data + zinc_data + lead_data + uranium_data + molybdenum_data + cobalt_data + wo3_data + antimony_data + u3o8_data + niobium_oxide_data + tantalum_oxide_data>0
gen data=0 if gold_data + silver_data + copper_data + zinc_data + lead_data + uranium_data + molybdenum_data + cobalt_data + wo3_data + antimony_data + u3o8_data + niobium_oxide_data + tantalum_oxide_data==0
replace data =1 if data!=0

/* calculate the grades for each mine */
destring ore_milled1, replace
destring ore_milled3, replace
gen ore_milled1_ton = ore_milled1*1.1023 if ore_milled2 == "tonnes" | ore_milled2 == "mtons"
replace ore_milled1_ton = ore_milled1 if ore_milled2 == "tons"
gen ore_milled3_ton = ore_milled3*1.1023 if ore_milled2 == "tonnes" | ore_milled2 == "mtons"
replace ore_milled3_ton = ore_milled3 if ore_milled2 == "tons"
count if ore_milled_data ==1

split gold_grade, p(" ")
replace gold_grade2=gold_grade4 if gold_grade2=="+"
split gold_prod, p(" ")
replace gold_prod2=gold_prod4 if gold_prod2=="+"
destring gold_grade1, replace
destring gold_prod1, replace
destring gold_grade3, replace
destring gold_prod3, replace
tab gold_grade2 //need to check whether the units are the same under one variable
tab gold_prod2 
gen gold_grade_compare = gold_prod1/ore_milled1_ton
replace gold_grade_compare = (gold_prod1 + gold_prod3)/(ore_milled1_ton + ore_milled3_ton) if gold_prod3!=. & ore_milled3!=.
gen gold_grade_weighed = gold_grade1
replace gold_grade_weighed = gold_grade1*ore_milled1_ton/(ore_milled1_ton + ore_milled3_ton) + gold_grade3*ore_milled3_ton/(ore_milled1_ton + ore_milled3_ton) if gold_grade3!=. & ore_milled3!=.
gen gold_grade_diff = (gold_grade_weighed - gold_grade_compare)/gold_grade_weighed
gen gold_grade_combine = gold_grade_weighed
replace gold_grade_combine = gold_grade_compare if gold_grade_combine == .

split silver_grade, p(" ")
* replace silver_grade2=silver_grade4 if silver_grade2=="+"
split silver_prod, p(" ")
* replace silver_prod2=silver_prod4 if silver_prod2=="+"
destring silver_grade1, replace
destring silver_prod1, replace
destring silver_prod3, replace
//need to check whether the units are the same under one variable
tab silver_grade2 
tab silver_prod2 
tab silver_prod4 
count if length(silver_prod)!=0 
gen silver_grade_compare = silver_prod1/ore_milled1_ton
replace silver_grade_compare = (silver_prod1 + silver_prod3)/(ore_milled1_ton + ore_milled3_ton) if silver_prod3!=. & ore_milled3!=.
gen silver_grade_weighed = silver_grade1
gen silver_grade_diff = (silver_grade_weighed - silver_grade_compare)/silver_grade_weighed
gen silver_grade_combine = silver_grade_weighed
replace silver_grade_combine = silver_grade_compare if silver_grade_combine == .

* I need to unify the unit for copper grade is % in 1980 minebook data
gen copper_grade_tail = substr(copper_grade, -1, 1)
tab copper_grade_tail
count if length(copper_grade)!=0
replace copper_grade = substr(copper_grade, 1, length(copper_grade)-1)
split copper_grade, p(" ")
replace copper_grade = copper_grade + copper_grade_tail
destring copper_grade1, replace
destring copper_grade3, replace
split copper_prod, p(" ")
destring copper_prod1, replace
destring copper_prod3, replace
// need to check whether the units are the same under one variable
tab copper_prod2
tab copper_prod4
gen copper_prod1_ton = copper_prod1 if copper_prod2 == "tons"
replace copper_prod1_ton = copper_prod1*0.0005 if copper_prod2 == "lb"
replace copper_prod1_ton = copper_prod1*0.0011 if copper_prod2 == "kg"
gen copper_prod3_ton = copper_prod3 if copper_prod4 == "tons"
replace copper_prod3_ton = copper_prod3*0.0005 if copper_prod4 == "lb"
replace copper_prod3_ton = copper_prod3*0.0011 if copper_prod4 == "kg"
gen copper_grade_compare = copper_prod1_ton / ore_milled1_ton*100
replace copper_grade_compare = (copper_prod1_ton + copper_prod3_ton)/ (ore_milled1 + ore_milled3_ton)*100 if copper_prod3_ton != . & ore_milled3!= .
gen copper_grade_weighed = copper_grade1
replace copper_grade_weighed = copper_grade1 * ore_milled1/(ore_milled1 + ore_milled3) + copper_grade3 * ore_milled3/(ore_milled1 + ore_milled3) if copper_prod3_ton != . & ore_milled3!= .
gen copper_grade_diff = (copper_grade_weighed - copper_grade_compare)/copper_grade_weighed
gen copper_grade_combine = copper_grade_weighed
replace copper_grade_combine = copper_grade_compare if copper_grade_combine == .


* I need to unify the unit for zinc grade is % in 1980 minebook data
gen zinc_grade_tail = substr(zinc_grade, -1, 1)
tab zinc_grade_tail
count if length(zinc_grade)!=0
replace zinc_grade = substr(zinc_grade, 1, length(zinc_grade)-1)
split zinc_grade, p(" ")
replace zinc_grade = zinc_grade + zinc_grade_tail
destring zinc_grade1, replace
split zinc_prod, p(" ")
destring zinc_prod1, replace
*need to check whether the units are the same under one variable
tab zinc_prod2
count if length(zinc_prod)!=0
gen zinc_prod_ton = zinc_prod1 if zinc_prod2 == "tons"
replace zinc_prod_ton = zinc_prod1*0.0005 if zinc_prod2 == "lb"
replace zinc_prod_ton = zinc_prod1*0.0011 if zinc_prod2 == "kg"
gen zinc_grade1_compare = zinc_prod_ton / ore_milled1_ton*100
gen zinc_grade_diff = (zinc_grade1 - zinc_grade1_compare)/zinc_grade1
gen zinc_grade_combine = zinc_grade1
replace zinc_grade_combine = zinc_grade1_compare if zinc_grade_combine == .
count if zinc_grade_combine!=.
count if zinc_data==1

gen lead_grade_tail = substr(lead_grade, -1, 1)
tab lead_grade_tail
count if length(lead_grade)!=0
replace lead_grade = substr(lead_grade, 1, length(lead_grade)-1)
split lead_grade, p(" ")
replace lead_grade = lead_grade + lead_grade_tail
destring lead_grade1, replace
split lead_prod, p(" ")
destring lead_prod1, replace
*need to check whether the units are the same under one variable
tab lead_prod2
gen lead_prod_ton = lead_prod1 if lead_prod2 == "tons"
* conversion info is from mine handbook 1980
replace lead_prod_ton = lead_prod1*0.0005 if lead_prod2 == "lb"
replace lead_prod_ton = lead_prod1*0.0011 if lead_prod2 == "kg"
gen lead_grade1_compare = lead_prod_ton / ore_milled1_ton*100
gen lead_grade_diff = (lead_grade1 - lead_grade1_compare)/lead_grade1
gen lead_grade_combine = lead_grade1
replace lead_grade_combine = lead_grade1_compare if lead_grade_combine == .
count if lead_grade_combine!=.
count if lead_data==1

/* Keep mines that content only metals with World Bank price.*/
count if gold_data + silver_data + copper_data + zinc_data + lead_data>0
keep if gold_data + silver_data + copper_data + zinc_data + lead_data>0
gen metal_numb_prod = gold_data + silver_data + copper_data + zinc_data + lead_data + uranium_data + molybdenum_data + wo3_data + antimony_data + niobium_oxide_data
gen trim_numb_prod = gold_data + silver_data + copper_data + zinc_data + lead_data
keep if trim_numb_prod == metal_numb_prod & trim_numb_prod>0
keep province company minesite location *_combine trim_numb_prod
* keep province company minesite location *_grade *_combine trim_numb_prod begin_date suspend_date reopen_date duration close_date
save "P:\Liu_5114\result\handbook-data\1980-prod-trimmed", replace

/* Next step is to clean the "P:\Liu_5114\mine-handbook-1980-reserve-2.csv" file and merge this trimmed production data with it.
/* Next do-file is "1980-handbook-data-cleaning-res"




