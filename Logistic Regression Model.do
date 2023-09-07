**Getting statistics for the variables**
tabstat WEAT_score PositiveSentences NegativeSentences NeutralSentences TotalSentences reference_count Num_words, by(Gender) statistics(mean sd median min max)

replace reference_count = 25.55 if reference_count == 0 
gen RC = log(reference_count)
gen NW = log(Num_words)

**OLS regression**
reg Code WEAT_score PositiveSentences NegativeSentences NeutralSentences reference_count Num_words D E F G H present LP CP Independent LD SNP Others, robust
**saving the results 
estimates store model1

**Logit model with the main dependent variables**
logit Code WEAT_score PositiveSentences NegativeSentences NeutralSentences, robust
**saving the results**
estimates store model2

**Logit model with dependent variables and controls**
logit Code WEAT_score PositiveSentences NegativeSentences NeutralSentences reference_count Num_words D E F G H present LP CP Independent LD SNP Others, robust
**saving the model**
estimates store model3 

**Logit model with dependent variables and controls in which log of reference_count and Num_words are being used to account for their high skewness**
logit Code WEAT_score PositiveSentences NegativeSentences NeutralSentences RC NW D E F G H present LP CP Independent LD SNP Others,robust
**saving the model**
estimates store model4 

**comparing the models**
estimates table model1 model2 model3 model4, star(0.1 0.05 0.001) stats(N r2 r2_a)

estimates table model1 model2 model3 model4, star(0.1 0.05 0.001) stats(N r2 r2_p)
 
**Getting the final table**
estout model1 model2 model3 model4, cells(b(star fmt(3)) se(par fmt(3))) starlevels(* .1 ** .05 *** .01) stats(r2 r2_p N, fmt(3 4 0) label("R-squared""Pseudo R-squared""Number of Obs.")) number collabels(none) mlabels(none)
