#!/usr/bin/env Rscript

# Leslie Huang

### Set up the workspace

args = commandArgs(trailingOnly=TRUE)

setwd(args[1])

load("un_img_new_dfm.RData")

set.seed(1234)

library("topicmodels")
#library("ldatuning")
#library("lda")
#library("quanteda")


# Run the topic model

# 65
model_65 <- LDA(tm_dfm, k = 65, control = list(seed = 1234))

save.image("un_img_new_dfm_10-30-17.RData")