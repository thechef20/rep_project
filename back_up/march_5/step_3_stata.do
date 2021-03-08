*3/2/21
cd /Users/benrudnick/Desktop/Fin_replication_project
clear
cls
*import lib if you do not already have
*ssc install gtools
import delimited using pre_rank_table.csv
save pre_rank_table.dta, replace

*import data on the portoflios
use sfz_portm,clear 

*get rid of the profolios which do not add value
drop if mpindno>1000091 
drop if mpindno<1000082
save porflio_weights_data_clean.dta, replace

*this file came from MATLAB
use pre_rank_table , clear
*removing data where the years don't have data data b/c it is less than 2 yr
drop if pre_ranked_beta == . 
*meging the market weight prolfios onto to data
merge m:1 kypermno annual using porflio_weights_data_clean.dta 
keep if _merge == 3
drop _merge


*expirmental...
sort kypermno annual mmonth
egen firm_time_id = group(mpportnum annual mmonth)

* xtile but faster!
fasterxtile beta_decile = (pre_ranked_beta), by(firm_time_id) nq(10)
*this sort gives me fear
sort kypermno annual mmonth beta_decile mpportnum
export delimited using end_of_step_3_stata.csv, replace

save merged_portfolio_and_preranked_beta_data.dta, replace

*new sort that will be used to merge the post rank beta my market weight and beta weight
sort beta_decile mpportnum
egen unique_beta_and_mpportnum = group(beta_decile mpportnum)
save input_for_crosssectional.dta, replace




