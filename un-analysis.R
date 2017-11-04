# Leslie Huang

### Set up the workspace
rm(list=ls())
setwd("/Users/lesliehuang/un-analysis/")

set.seed(1234)

libraries <- c("foreign", "utils", "dplyr", "plyr", "devtools", "quanteda", "ggplot2", "topicmodels", "lda", "ldatuning", "LDAvis", "stringi")
lapply(libraries, require, character.only=TRUE)

load("un_img_new_dfm.RData")

#########################################

# set controls
controls_tm <- list(
  burnin = 1000,
  iter = 4000,
  thin = 500,
  nstart = 5,
  seed = 0:4,
  best = TRUE
)

num_cores <- max(parallel::detectCores() - 1, 1)

#########################################
# Run the topic model

# 50
model_50 <- LDA(tm_dfm, k = 50, control = controls_tm)
Topic <- topics(model_50, 1)
Terms <- terms(model_50, 10)

save.image("un_models65.RData")

# 65
model_65 <- LDA(tm_dfm, k = 65, control = controls_tm)

save.image("un_models65.RData")

# 58
model_58 <- LDA(un_dfm, k = 58, control = list(seed = 1234))

# 75
model_75 <- LDA(un_dfm, k = 75, control = list(seed = 1234))
