* getting the N by T and calling it a day :)
cd /Users/matt/Desktop/Fin_replication_project
*cd /Users/matt/Desktop/Fin_replication_project
clear
cls
*ssc install asreg
* Building the table

* the point of this is to replace the worl "mmonths" with annual for merging purposes
use risk_free_data, clear 
gen annual= myear
drop myear
save risk_free_data_annual.dta, replace


use risk_free_data_annual, clear




merge 1:m  annual mmonth using input_for_crosssectional.dta

keep if _merge == 3
drop _merge
drop junk 
sort unique_beta_and_mpportnum 
collapse (mean) mretx hml smb rmw cma modate, by(unique_beta_and_mpportnum annual mmonth)
sort annual mmonth
egen indexy_time_var = group(annual mmonth)
sort unique_beta_and_mpportnum annual mmonth
export delimited "out_of_stata_five_factor.csv",replace


