*Project
*Student Name: Rohan Patil
*Student ID: RSP210001
*Date: 11/28/2022

cd "H:\BUAN 6312"

* setup
capture log close // closes any unclosed logs
set more off // does not pause when review window is full

* open log file
log using week1, replace text // use log file with text format

import delimited  insurance.csv

save  insurance.dta

summarize

table(sex)

table(smoker)

table(region)

duplicates report
duplicates list
duplicates drop
duplicates report

gen dsex = 1 if sex== "female"
replace dsex = 0 if sex == "male"

tabulate sex, generate(dsex)

gen dsmoker = 1 if smoker== "yes"
replace dsmoker = 0 if smoker == "no"

tabulate smoker , generate(dsmoker)

encode region, gen(dregion)
tabulate dregion, nolabel

tabulate region, generate(dregion)

tabulate children , generate(dchildren)

recode age (18/24= 1 "18-24") (25/35=2 "25-35") (36/45=3 "36-45") (46/59=4 "46-59") (60/64 =5 "60 +"), gen(agegrp)

histogram charges

histogram dsmoker, percent discrete

corr charges age dsex bmi children dsmoker dregion

reg charges dsex bmi children dsmoker dregion
reg charges agegrp dsex bmi children dsmoker dregion

reg charges age bmi dsmoker2

reg charges i.dsmoker##age bmi i.dsmoker#c.bmi

reg charges i.dsmoker##agegrp bmi i.dsmoker#c.bmi
predict y
scatter charges y
scatter charges y || lfit charges y
scatter charges y if dsmoker==1 || scatter charges y if dsmoker==0
list charges y in 1/10
list age dsmoker bmi charges y in 1/10
predict residu, residuals
list charges y residu in 1/10
scatter residu y

reg charges  c.age##c.age c.bmi##c.bmi  dsmoker2