* Step 4
cd /Users/benrudnick/Desktop/Fin_replication_project
clear
cls

use merged_portfolio_and_preranked_beta_data

* Building the table

*Table 1A
collapse (mean) mretx, by(mpportnum beta_decile)
sort mpportnum beta_decile

reshape wide mretx, i(mpportnum) j(beta_decile)

export delimited using "table_1_A", replace 

* Table 2=1B
use merged_portfolio_and_preranked_beta_data, clear

collapse (mean) pre_ranked_beta, by(mpportnum beta_decile)
sort mpportnum beta_decile

reshape wide pre_ranked_beta, i(mpportnum) j(beta_decile)

export delimited using "table_1_B_postranked", replace

* Table 2=1C
use merged_portfolio_and_preranked_beta_data, clear
gen mcap_log = log(mtcap)

collapse (mean) mcap_log, by(mpportnum beta_decile)
sort mpportnum beta_decile

reshape wide mcap_log, i(mpportnum) j(beta_decile)

export delimited using "table_1_C_Size", replace
