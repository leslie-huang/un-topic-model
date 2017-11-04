# Leslie Huang

### Set up the workspace
rm(list=ls())
setwd("/Users/lesliehuang/un-analysis/")

load("~/Desktop/un_models.RData")

set.seed(1234)

libraries <- c("foreign", "utils", "dplyr", "plyr", "devtools", "quanteda", "ggplot2", "topicmodels", "lda", "ldatuning", "LDAvis", "stringi")
lapply(libraries, require, character.only=TRUE)

# Examine models with different k
# Sparsity for DFM: min = 0.5%, max = 90%
# TM settings: 5 starts, 4000 iter, 1000 burnin, 500 thin

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
