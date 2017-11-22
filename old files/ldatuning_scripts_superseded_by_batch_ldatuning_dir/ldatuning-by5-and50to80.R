# Leslie Huang

### Set up the workspace
rm(list=ls())
setwd("/Users/lesliehuang/un-analysis/")

load("un_base_workspace.RData")

set.seed(1234)

libraries <- c("foreign", "utils", "dplyr", "plyr", "devtools", "quanteda", "ggplot2", "topicmodels", "lda", "ldatuning", "LDAvis", "stringi")
lapply(libraries, require, character.only=TRUE)

#########################################
# Choose k

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

result <- FindTopicsNumber(un_dfm, topics = seq(40, 100, by = 5), metrics = c("Griffiths2004", "CaoJuan2009", "Arun2010", "Deveaud2014"), mc.cores = num_cores, control = controls_tm, verbose = TRUE)


# FindTopicsNumber_plot(result)


# result3 <- FindTopicsNumber(un_dfm, topics = seq(50, 64, by = 2), metrics = c("Griffiths2004", "CaoJuan2009", "Arun2010", "Deveaud2014"), mc.cores = num_cores, control = controls_tm, verbose = TRUE)

result4 <- FindTopicsNumber(un_dfm, topics = seq(50, 80, by = 1), metrics = c("Griffiths2004", "CaoJuan2009", "Arun2010", "Deveaud2014"), mc.cores = num_cores, verbose = TRUE)

save.image("un_findk_10-31-17.RData")
