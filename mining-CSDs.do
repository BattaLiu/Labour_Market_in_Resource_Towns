* Labour Markets in Resource Towns *
* Jiayi Liu *
* Nov 2017 *

/* 1981 */
/* For matching mine CSDs with minebook data*/
clear
import delimited P:\Liu_5114\mines-CSD\mine-30th-matched3-2-reversed.csv
replace minesite ="" if minesite=="NA"
save "P:\Liu_5114\result\CSDs\mine-30th-matched3-2", replace

/* For matching mine CSDs with residence CSD. Add a boolean variable to 1981 census data indicating the mine poccession.*/
clear
import delimited P:\Liu_5114\mines-CSD\mine-30th-matched3-2-reversed.csv
rename csduid pcsd
duplicates tag pcsd, gen(dup)
duplicates drop pcsd, force
* keep pcsd company location dup
keep pcsd dup
save "P:\Liu_5114\result\CSDs\1981-mining-CSD-map", replace
rename pcsd pow
save "P:\Liu_5114\result\CSDs\1981-mining-CSD-map2", replace
rename pow sgccsd81
merge 1:1 sgccsd81 using "P:\Liu_5114\mines-CSD\mine-CSD-81-mainCSD16"
drop _merge
save "P:\Liu_5114\result\CSDs\1981-mining-CSD-map-consistent16", replace


* This file adds an important variable to labor-outcome-appended.dta: mineCSD81,
* which indicates whether it is a CSD with principal mine in 1981 (but the location 
* data is from 900a map of 1980 made at the beginning of the reference year).
clear
import delimited P:\Liu_5114\mines-CSD\mine-30th-matched3-2-reversed.csv
rename csduid pcsd
duplicates drop pcsd, force
export delimited using "P:\Liu_5114\mine-30th-matched3-uniqueCSD.csv", replace

merge 1:m pcsd using "P:\Liu_5114\result\labor market outcome\labor-outcome-appended"
rename _merge mineCSD81
replace mineCSD81=0 if mineCSD81!=3
replace mineCSD81=1 if mineCSD81==3
save "P:\Liu_5114\result\labor market outcome\labor-outcome-appended-v1.dta",replace

/* 1986 */
clear
import delimited P:\Liu_5114\mines-CSD\mine-35th-matched3.csv
replace minesite ="" if minesite=="NA"
save "P:\Liu_5114\result\CSDs\mine-35th-matched3", replace

clear
import delimited P:\Liu_5114\mines-CSD\mine-35th-matched3.csv
rename csduid pcsd
duplicates tag pcsd, gen(dup)
duplicates drop pcsd, force
* keep pcsd company location dup
keep pcsd dup
save "P:\Liu_5114\result\CSDs\1986-mining-CSD-map", replace
rename pcsd pow
save "P:\Liu_5114\result\CSDs\1986-mining-CSD-map2", replace

/* 1991 */
clear
import delimited P:\Liu_5114\mines-CSD\mine-40th-matched3-reversed.csv
replace minesite ="" if minesite=="NA"
save "P:\Liu_5114\result\CSDs\mine-40th-matched3", replace

clear
import delimited P:\Liu_5114\mines-CSD\mine-40th-matched3-reversed.csv
rename csduid pcsd
duplicates tag pcsd, gen(dup)
duplicates drop pcsd, force
* keep pcsd company location dup
keep pcsd dup
save "P:\Liu_5114\result\CSDs\1991-mining-CSD-map", replace
rename pcsd pow
save "P:\Liu_5114\result\CSDs\1991-mining-CSD-map2", replace

/* 1996 */
clear
import delimited P:\Liu_5114\mines-CSD\mine-45th-matched3.csv
replace minesite ="" if minesite=="NA"
replace province = upper(province)
save "P:\Liu_5114\result\CSDs\mine-45th-matched3", replace

clear
import delimited P:\Liu_5114\mines-CSD\mine-45th-matched3.csv
rename csduid pcsd
duplicates tag pcsd, gen(dup)
duplicates drop pcsd, force
* keep pcsd company location dup
keep pcsd dup
save "P:\Liu_5114\result\CSDs\1996-mining-CSD-map", replace
rename pcsd pow
save "P:\Liu_5114\result\CSDs\1996-mining-CSD-map2", replace

/* 2001 */
clear
import delimited P:\Liu_5114\mines-CSD\mine-handbook-2000-prod-v2.csv
replace minesite ="" if minesite=="NA"
keep province company minesite location csduid csdname
save "P:\Liu_5114\result\CSDs\mine-50th-matched3", replace

clear
import delimited P:\Liu_5114\mines-CSD\mine-handbook-2000-prod-v2.csv
rename csduid pcsd
duplicates tag pcsd, gen(dup)
duplicates drop pcsd, force
* keep pcsd company location dup
keep pcsd dup
save "P:\Liu_5114\result\CSDs\2001-mining-CSD-map", replace
rename pcsd pow
save "P:\Liu_5114\result\CSDs\2001-mining-CSD-map2", replace

/* 2006 */
clear
import delimited P:\Liu_5114\mines-CSD\mine-handbook-2005-prod-v2.csv
replace minesite ="" if minesite=="NA"
keep province company minesite location csduid csdname
save "P:\Liu_5114\result\CSDs\mine-55th-matched3", replace

clear
import delimited P:\Liu_5114\mines-CSD\mine-handbook-2005-prod-v2.csv
rename csduid pcsd
duplicates tag pcsd, gen(dup)
duplicates drop pcsd, force
* keep pcsd company location dup
keep pcsd dup
save "P:\Liu_5114\result\CSDs\2006-mining-CSD-map", replace
rename pcsd pow
save "P:\Liu_5114\result\CSDs\2006-mining-CSD-map2", replace
