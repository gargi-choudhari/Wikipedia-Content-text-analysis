clear 
import excel "C:\Users\gargi\Downloads\Logit model data 1.xlsx", sheet("Sheet1") firstrow

**Getting statistics for the variables**
tabstat WEAT_score PositiveSentences NegativeSentences NeutralSentences TotalSentences reference_count Num_words, by(Gender) statistics(mean sd median min max)

gen logmonth = log(AverageViewsMonthly)

**logit model without samplings and controls 
logistic Code WEAT_score PositiveSentences NegativeSentences NeutralSentences, robust
estimates store model1

**logit without samplings and with controls 
logistic Code WEAT_score PositiveSentences NegativeSentences NeutralSentences LP CP Independent LD SNP Others D E F G H present reference_count Num_words logmonth, robust 
estimates store model2

clear 

import excel "C:\Users\gargi\Desktop\Jupyter Notebook\df_upsampled.xlsx", sheet("Sheet1") firstrow

**logit with samplings but without controls 
logistic Code WEAT_score PositiveSentences NegativeSentences NeutralSentences, robust
estimates store model3
lroc
graph export "lroc3.png", as(png) replace

gen logmonth = log(AverageViewsMonthly)

rename E D
rename F E
rename G F
rename H G
rename I H 

**logit with samplings and controls
logistic Code WEAT_score PositiveSentences NegativeSentences NeutralSentences LP CP Independent LD SNP Others D E F G H present reference_count Num_words logmonth, robust
estimates store model4 

esttab model1 model2 model3 model4, b(%9.2f) se(%9.2f) label
