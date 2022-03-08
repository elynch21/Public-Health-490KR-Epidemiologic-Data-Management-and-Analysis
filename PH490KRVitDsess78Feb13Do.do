*Emily Lynch PH490KR*
*Created: Feb  13, 2018*
*Modified: Feb 15, 2018*

*Purpose: to practice using stata to create new variables*

*Open Data Set*
"C:\Users\emilylynch\Downloads\VitDsess78.dta"

*describe*

*cross tabulate for ever smoker, curent smoker, missing*
tabulate ev_smk cur_smk, miss

*Create new variable smoke, set as missing "."*
generate smoke=.

*Data -> Variables Manager -> Value label -> Manage -> create label*
*Smoke_new -> 0=Never 1=Past 2=Current*

label define Smoke_new 0 "Never" 1 "Past" 2 "Current"

label values smoke Smoke_new

*check that all are set to missing*
tabulate smoke

*create new variable*
replace smoke=0 if ev_smk==0 & cur_smk==0
replace smoke=1 if ev_smk==1 & cur_smk==0
replace smoke=2 if ev_smk==1 & cur_smk==1
replace smoke=2 if ev_smk==0 & cur_smk==1

*Create a new variable dichotomizing weight at the median*
*xtile = Statistics > Summaries, tables, and tests > Summary and descriptive* 
*statistics > Create variable of quantiles*
xtile wt_01 = wt_lbs

tabulate wt_01, miss

*Create new variable for BMI*
*BMI=((wt_lbs)/(ht_in*ht_in))*703*
generate BMI=((wt_lbs)/(ht_in*ht_in))*703
label bmi "bmi=

sum BMI

*Create a new variable grouping BMI into quartiles*
xtile BMI_01 = BMI, nquantiles(4)

*check*
list id BMI BMI_01 in 1/25

*Label the quartile variables*
*First get cut off points with sum*
sum BMI, d
*25% 20.59, 50% 22.58, 75% 24.54*
label define BMI_quartf 1 "1:<20.59" 2 "2:20.59-<22.58" 3 "3:22.58-<24.54" 4 "4:24.54-40"
label values BMI_01 BMI_quartf
*Check*
tab BMI_01

*Create new variable that groups BMI according to WHO definitions*
*Underweight (<18.5), normal (18.5-<25), overweight (25-<30), obese (>30)*
generate BMI_cat=.





