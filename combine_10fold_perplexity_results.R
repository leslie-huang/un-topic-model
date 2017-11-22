# Leslie Huang

# Combine all ldatuning results from cluster jobs

### Set up the workspace
rm(list=ls())
setwd("/Users/lesliehuang/un-analysis/")

load("perplexity_kfold_combined.RData")
# This workspace combined results of 10 fold cross validated held out perplexity for models that were individually run on the HPC cluster. See the batch_kfold_perplexity dir for details

set.seed(1234)

libraries <- c("foreign", "utils", "dplyr", "plyr", "ggplot2", "devtools", "quanteda", "stringi", "topicmodels", "ldatuning", "lda")
lapply(libraries, require, character.only=TRUE)

perplexity_result_dfs <- (list = ls(pattern="^perplexity_results_"))

combined_perplexity_results <- data.frame(matrix(NA, ncol = 10, nrow = length(perplexity_result_dfs)))

# Combine perplexity results into new dataframe
for (i in 1:length(perplexity_result_dfs) ) {
  combined_perplexity_results[i, ] <- get(perplexity_result_dfs[i])
}

rownames(combined_perplexity_results) <- perplexity_result_dfs

combined_perplexity_results$mean_log <- rowMeans(log(combined_perplexity_results))


save.image("perplexity_kfold_combined.RData")
