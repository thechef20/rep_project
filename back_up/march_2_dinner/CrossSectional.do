* Cross Sectional
cd /Users/matt/Desktop/Fin_replication_project
clear
cls

* Building the table

*Table 1A RETURNS
use merged_portfolio_and_preranked_beta_data, clear

collapse (mean) mretx, by(mpportnum beta_decile)
sort mpportnum beta_decile

****
*insert setp 5 code*
****
gen average_returns_beta_mkcap = mretx
drop mretx

sort beta_decile mpportnum
egen unique_beta_and_mpportnum = group(beta_decile mpportnum)

save returns_part_1.dta, replace
use output_for_crosssectional, clear 


merge m:1 unique_beta_and_mpportnum using returns_part_1.dta
drop _merge
save output_for_crosssectional.dta, replace





* Table 2=1B POST BETA
use merged_portfolio_and_preranked_beta_data, clear

collapse (mean) pre_ranked_beta, by(mpportnum beta_decile)
sort mpportnum beta_decile
****
*insert setp 5 code*
****


gen average_pre_rank_beta = pre_ranked_beta
drop pre_ranked_beta

sort beta_decile mpportnum
egen unique_beta_and_mpportnum = group(beta_decile mpportnum)

save returns_part_2.dta, replace
use output_for_crosssectional, clear
merge m:1 unique_beta_and_mpportnum using returns_part_2.dta
drop _merge
save output_for_crosssectional.dta, replace






* Table 2=1C LOG SIZE
use merged_portfolio_and_preranked_beta_data, clear
gen mcap_log = log(mtcap)

collapse (mean) mcap_log, by(mpportnum beta_decile)
sort mpportnum beta_decile
****
*insert setp 5 code*
****

gen average_mcap_log = mcap_log
drop mcap_log

sort beta_decile mpportnum
egen unique_beta_and_mpportnum = group(beta_decile mpportnum)

save returns_part_3.dta, replace
use output_for_crosssectional, clear
merge m:1 unique_beta_and_mpportnum using returns_part_3.dta
drop _merge
save output_for_crosssectional_final.dta, replace

