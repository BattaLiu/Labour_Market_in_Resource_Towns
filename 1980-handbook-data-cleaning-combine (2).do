* Labour Markets in Resource Towns *
* Jiayi Liu *
* Created: Jan 2018 *

* This file adds CSD and CD info to mine price data, which is created from an R file.
clear
import delimited "P:/Liu_5114/result/handbook-data/1980-trimmed-price-real2002.csv"
drop x_merge
merge 1:m province company minesite location using "P:\Liu_5114\result\CSDs\mine-30th-matched3-2"
keep if _merge == 3
drop _merge 
duplicates drop csduid, force
rename csduid pcsd
save "P:/Liu_5114/result/handbook-data/1980-trimmed-price-real2002-CSD",replace
rename * *_pow
rename pcsd_pow pow
save "P:/Liu_5114/result/handbook-data/1980-trimmed-price-real2002-CSD2",replace

clear
import delimited "P:/Liu_5114/result/handbook-data/1980-trimmed-price-real2002.csv"
drop x_merge
merge 1:m province company minesite location using "P:\Liu_5114\result\CSDs\mine-30th-matched3-2"
keep if _merge == 3
tostring(csduid), gen (csd_str)
gen cd_str = substr(csd_str, 1, 4)
destring(cd_str), gen (cd)
drop cd_str
duplicates tag cd, gen(dup)
duplicates drop cd, force
rename cd pcd
save "P:/Liu_5114/result/handbook-data/1980-trimmed-price-real2002-CD",replace
rename * *_pow
rename pcd_pow pow
save "P:/Liu_5114/result/handbook-data/1980-trimmed-price-real2002-CD2",replace

/* 1985 */
* This file adds CSD and CD info to mine price data, which is created from an R file.
clear
import delimited "P:/Liu_5114/result/handbook-data/1985-trimmed-price-real2002.csv"
drop x_merge
merge 1:m province company minesite location using "P:\Liu_5114\result\CSDs\mine-35th-matched3"
keep if _merge == 3
drop _merge 
duplicates drop csduid, force
rename csduid pcsd
save "P:/Liu_5114/result/handbook-data/1985-trimmed-price-real2002-CSD",replace
rename * *_pow
rename pcsd_pow pow
save "P:/Liu_5114/result/handbook-data/1985-trimmed-price-real2002-CSD2",replace

clear
import delimited "P:/Liu_5114/result/handbook-data/1985-trimmed-price-real2002.csv"
drop x_merge
merge 1:m province company minesite location using "P:\Liu_5114\result\CSDs\mine-35th-matched3"
keep if _merge == 3
tostring(csduid), gen (csd_str)
gen cd_str = substr(csd_str, 1, 4)
destring(cd_str), gen (cd)
drop cd_str
duplicates tag cd, gen(dup)
duplicates drop cd, force
rename cd pcd
save "P:/Liu_5114/result/handbook-data/1985-trimmed-price-real2002-CD",replace
rename * *_pow
rename pcd_pow pow
save "P:/Liu_5114/result/handbook-data/1985-trimmed-price-real2002-CD2",replace

/* 1990 */
* This file adds CSD and CD info to mine price data, which is created from an R file.
************************Be careful, the 1990 res data has been ruined!!!!!!!!!!!!!!!!!!!!!!!!
clear
import delimited "P:/Liu_5114/result/handbook-data/1990-trimmed-price-real2002.csv"
drop x_merge
merge 1:m province company minesite location using "P:\Liu_5114\result\CSDs\mine-40th-matched3"
keep if _merge == 3
drop _merge 
duplicates drop csduid, force
rename csduid pcsd
save "P:/Liu_5114/result/handbook-data/1990-trimmed-price-real2002-CSD",replace
rename * *_pow
rename pcsd_pow pow
save "P:/Liu_5114/result/handbook-data/1990-trimmed-price-real2002-CSD2",replace

clear
import delimited "P:/Liu_5114/result/handbook-data/1990-trimmed-price-real2002.csv"
drop x_merge
merge 1:m province company minesite location using "P:\Liu_5114\result\CSDs\mine-40th-matched3"
keep if _merge == 3
tostring(csduid), gen (csd_str)
gen cd_str = substr(csd_str, 1, 4)
destring(cd_str), gen (cd)
drop cd_str
duplicates tag cd, gen(dup)
duplicates drop cd, force
rename cd pcd
save "P:/Liu_5114/result/handbook-data/1990-trimmed-price-real2002-CD",replace
rename * *_pow
rename pcd_pow pow
save "P:/Liu_5114/result/handbook-data/1990-trimmed-price-real2002-CD2",replace

/* 1995 */
* This file adds CSD and CD info to mine price data, which is created from an R file.
clear
import delimited "P:/Liu_5114/result/handbook-data/1995-trimmed-price-real2002.csv"
drop x_merge
replace province = upper(province)
merge 1:m province company minesite location using "P:\Liu_5114\result\CSDs\mine-45th-matched3"
keep if _merge == 3
drop _merge 
duplicates drop csduid, force
rename csduid pcsd
save "P:/Liu_5114/result/handbook-data/1995-trimmed-price-real2002-CSD",replace
rename * *_pow
rename pcsd_pow pow
save "P:/Liu_5114/result/handbook-data/1995-trimmed-price-real2002-CSD2",replace

clear
import delimited "P:/Liu_5114/result/handbook-data/1995-trimmed-price-real2002.csv"
drop x_merge
replace province = upper(province)
merge 1:m province company minesite location using "P:\Liu_5114\result\CSDs\mine-45th-matched3"
keep if _merge == 3
tostring(csduid), gen (csd_str)
gen cd_str = substr(csd_str, 1, 4)
destring(cd_str), gen (cd)
drop cd_str
duplicates tag cd, gen(dup)
duplicates drop cd, force
rename cd pcd
save "P:/Liu_5114/result/handbook-data/1995-trimmed-price-real2002-CD",replace
rename * *_pow
rename pcd_pow pow
save "P:/Liu_5114/result/handbook-data/1995-trimmed-price-real2002-CD2",replace

/* 2000 */
* This file adds CSD and CD info to mine price data, which is created from an R file.
clear
import delimited "P:/Liu_5114/result/handbook-data/2000-trimmed-price-real2002.csv"
drop x_merge
merge 1:m province company minesite location using "P:\Liu_5114\result\CSDs\mine-50th-matched3"
keep if _merge == 3
drop _merge 
duplicates drop csduid, force
rename csduid pcsd
save "P:/Liu_5114/result/handbook-data/2000-trimmed-price-real2002-CSD",replace
rename * *_pow
rename pcsd_pow pow
save "P:/Liu_5114/result/handbook-data/2000-trimmed-price-real2002-CSD2",replace

clear
import delimited "P:/Liu_5114/result/handbook-data/2000-trimmed-price-real2002.csv"
drop x_merge
merge 1:m province company minesite location using "P:\Liu_5114\result\CSDs\mine-50th-matched3"
keep if _merge == 3
tostring(csduid), gen (csd_str)
gen cd_str = substr(csd_str, 1, 4)
destring(cd_str), gen (cd)
drop cd_str
duplicates tag cd, gen(dup)
duplicates drop cd, force
rename cd pcd
save "P:/Liu_5114/result/handbook-data/2000-trimmed-price-real2002-CD",replace
rename * *_pow
rename pcd_pow pow
save "P:/Liu_5114/result/handbook-data/2000-trimmed-price-real2002-CD2",replace

/* 2005 */
* This file adds CSD and CD info to mine price data, which is created from an R file.
clear
import delimited "P:/Liu_5114/result/handbook-data/2005-trimmed-price-real2002.csv"
drop x_merge
merge 1:m province company minesite location using "P:\Liu_5114\result\CSDs\mine-55th-matched3"
keep if _merge == 3
drop _merge 
duplicates drop csduid, force
rename csduid pcsd
save "P:/Liu_5114/result/handbook-data/2005-trimmed-price-real2002-CSD",replace
rename * *_pow
rename pcsd_pow pow
save "P:/Liu_5114/result/handbook-data/2005-trimmed-price-real2002-CSD2",replace

clear
import delimited "P:/Liu_5114/result/handbook-data/2005-trimmed-price-real2002.csv"
drop x_merge
merge 1:m province company minesite location using "P:\Liu_5114\result\CSDs\mine-55th-matched3"
keep if _merge == 3
tostring(csduid), gen (csd_str)
gen cd_str = substr(csd_str, 1, 4)
destring(cd_str), gen (cd)
drop cd_str
duplicates tag cd, gen(dup)
duplicates drop cd, force
rename cd pcd
save "P:/Liu_5114/result/handbook-data/2005-trimmed-price-real2002-CD",replace
rename * *_pow
rename pcd_pow pow
save "P:/Liu_5114/result/handbook-data/2005-trimmed-price-real2002-CD2",replace
