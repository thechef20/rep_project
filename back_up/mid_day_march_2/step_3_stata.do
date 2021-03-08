*2/27/21
cd /Users/benrudnick/Desktop/Fin_replication_project
clear
cls
*import lib if you do not already have
*ssc install gtools
import delimited using pre_rank_table.csv
save pre_rank_table.dta, replace

*use sfz_mind.dta
use sfz_portm,clear 

drop if mpindno>1000091 
drop if mpindno<1000082
save porflio_weights_data_clean.dta, replace

use pre_rank_table , clear
*need this to make the collapse work (might be problems for relefence on mtcap)
drop if pre_ranked_beta == . 
merge m:1 kypermno annual using porflio_weights_data_clean.dta 
keep if _merge == 3
drop _merge

*collapse (mean) pre_ranked_beta mtcap mretx, by(kypermno annual)

* ask connolly about the reasons for dropping???
drop if pre_ranked_beta ==.
drop if mpportnum ==.


*make table 

egen firm_time_id = group(mpportnum annual mmonth)
* xtile but faster!

fasterxtile beta_decile = (pre_ranked_beta), by(firm_time_id) nq(10)
save merged_portfolio_and_preranked_beta_data.dta, replace

collapse (mean) mtcap mretx, by(mpportnum beta_decile)



*egen firm_time_id=xtile(x), n(4) by(year)


*collapse (mean) pre_ranked_beta mtcap mretx ,by(postrank_10 postrank_20 postrank_30 postrank_40 postrank_50 postrank_60 postrank_70 postrank_80 postrank_90 postrank_100)
*bysort mpportnum annual mmonth: xtile beta_rank_value = pre_ranked_beta, nq(10) *maybe wrong????
save pre_rank_beta_output.dta, replace
use merged_portfolio_and_preranked_beta_data
*export delimited using "pre_rank_beta_output_hopefully.csv", replace

*merge m:1 mpportnum kypermno beta_decile using merged_portfolio_and_preranked_beta_data.dta 

collapse 

* return list
