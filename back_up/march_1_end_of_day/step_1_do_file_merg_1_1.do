*2/25/21
* setting up the  enviorment
cd /Users/matt/Desktop/Fin_replication_project
clear
cls
* importing the market data for returns month and year and saving as dta
import excel using kyindo_100080, firstrow
save kyindo_100080.dta, replace

* importing the entire dta for all of the single securities
use  sfz_mth, clear

* merging the market return onto the single secruity
merge m:1 myear mmonth using kyindo_100080.dta
drop _merge
sort kypermno myear mmonth
gen modate = ym(myear, mmonth) 
format %tm modate
save data_with_with_market_attached.dta, replace

*export delimited using "data_with_with_market_attached.csv", replace




* risk free 
import delimited using risk_free_data.csv,clear


gen modate = ym(myear, mmonth) 
format %tm modate
save risk_free_data.dta, replace
use data_with_with_market_attached,clear
*use data_with_with_market_attached, clear
merge m:1 modate using risk_free_data.dta
keep if _merge == 3
drop _merge
*things we can add bakc later if need be!!
drop mvol
drop mbid
drop mask
drop mspread
drop junk
drop mbidlo
drop maskhi
export delimited using "data_with_with_market_attached.csv", replace
*we might want this back in the off case that we need unique date idenfiter
*drop modate






*** junk/ things that may be useful down the road 

*individual
*use  sfz_mth, clear
*making the dta
