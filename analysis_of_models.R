# Leslie Huang

### Set up the workspace
rm(list=ls())
setwd("/Users/lesliehuang/un-analysis/")

# load the models
load("un_models.RData")

set.seed(1234)

libraries <- c("foreign", "utils", "dplyr", "plyr", "devtools", "quanteda", "ggplot2", "topicmodels", "lda", "ldatuning", "LDAvis", "stringi")
lapply(libraries, require, character.only=TRUE)


# Now look at the results from selected models

generate_wordlist <- function(model, num_words) {
  terms <- terms(model, num_words) # matrix, rows = words 1:num_words, cols = topics
  
  t_terms <- t(terms)
  
  t_terms <- as.data.frame(t_terms)
  return(t_terms)
}

terms_m50 <- generate_wordlist(model_50, 20)
#write.csv(terms_m50, file = "terms_m50.csv")

terms_m58 <- generate_wordlist(model_58, 20)
#write.csv(terms_m50, file = "terms_m58.csv")

terms_m65 <- generate_wordlist(model_65, 20)
#write.csv(terms_m65, file = "terms_m65.csv")

terms_m75 <- generate_wordlist(model_75, 20)
#write.csv(terms_m75, file = "terms_m75.csv")

terms_m80 <- generate_wordlist(model_80, 20)
#write.csv(terms_m80, file = "terms_m80.csv")

# Get topic proportions over documents for K = 80
topic_distr_over_docs <- model_80@gamma
write.csv(topic_distr_over_docs, file = "topic_distr_over_docs_80.csv")

# Mean topic proportions
mean_topic_distr <- colMeans(topic_distr_over_docs)

# Calculate SD
sds <- apply(topic_distr_over_docs, 2, sd)

write.csv(cbind(mean_topic_distr, sds), file="mean_topic_distr_80.csv")

write.csv(gd_speeches, file = "speeches_and_metadata_80.csv")

save.image("analysis_of_models.RData")
