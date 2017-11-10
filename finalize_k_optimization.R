# Leslie Huang

### Set up the workspace
rm(list=ls())
setwd("/Users/lesliehuang/un-analysis/")

# Bring all the results together
load("un_models.RData")
load("un_ldatuning_results.RData")
load("perplexity_kfold_combined.RData")

set.seed(1234)

libraries <- c("foreign", "utils", "dplyr", "plyr", "devtools", "quanteda", "ggplot2", "topicmodels", "lda", "ldatuning", "LDAvis", "stringi")
lapply(libraries, require, character.only=TRUE)

# Examine models with different k
# Sparsity for DFM: min = 0.5%, max = 90%
# TM settings: 5 starts, 4000 iter, 1000 burnin, 500 thin

# Plot the results from LDAtuning

FindTopicsNumber_plot(ldatuning_results[, c(1, 3:5)]) # exclude Griffiths because it's NA

# Plot the results from 10-fold heldout perplexity
qplot(seq(55,80,5), combined_perplexity_results$mean_log, xlab = "Number of topics", ylab = "Mean of log held-out perplexity from 10-fold cross-validation") + geom_line() + ggtitle("Results from held-out perplexity from 10-fold cross-validation")

# Now look at the results from selected models

generate_wordlist <- function(model, num_words) {
  terms <- terms(model, num_words) # matrix, rows = words 1:num_words, cols = topics
  
  t_terms <- t(terms)
  
  t_terms <- as.data.frame(t_terms)
  return(t_terms)
}

terms_m50 <- generate_wordlist(model_50, 20)
write.csv(terms_m50, file = "terms_m50.csv")

terms_m65 <- generate_wordlist(model_65, 20)
write.csv(terms_m65, file = "terms_m65.csv")


terms_m75 <- generate_wordlist(model_75, 20)
write.csv(terms_m75, file = "terms_m75.csv")

terms_m80 <- generate_wordlist(model_80, 20)
write.csv(terms_m80, file = "terms_m80.csv")

save.image("full_tm_workspace.RData")