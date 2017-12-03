# Leslie Huang

### Set up the workspace
rm(list=ls())
setwd("/Users/lesliehuang/un-analysis/")

# Bring all the results together
load("analysis_of_models.RData")
load("un_ldatuning_results.RData")
load("perplexity_kfold_combined.RData")

set.seed(1234)

libraries <- c("foreign", "utils", "dplyr", "plyr", "devtools", "quanteda", "ggplot2", "topicmodels", "lda", "ldatuning", "LDAvis", "stringi")
lapply(libraries, require, character.only=TRUE)

# Examine models with different k
# Sparsity for DFM: min = 0.5%, max = 90%
# TM settings: 5 starts, 4000 iter, 1000 burnin, 500 thin

# Plot the results from LDAtuning
ldatuning_20_100 <- dplyr::filter(ldatuning_results, topics <= 100)

png("tuning_plot_20_100.png", width = 1500, height = 800)
tuning_plot <- FindTopicsNumber_plot(ldatuning_20_100[, c(1, 3:5)]) # exclude Griffiths because it's NA
dev.off()

ldatuning_by5 <- dplyr::filter(ldatuning_results, grepl("5$", topics) | grepl("0$", topics))
png("tuning_plot_by5.png", width = 1500, height = 800)
tuning_plot <- FindTopicsNumber_plot(ldatuning_by5[, c(1, 3:5)]) # exclude Griffiths because it's NA
dev.off()


# Plot the results from 10-fold heldout perplexity
qplot(seq(40,90,1), combined_perplexity_results$mean_log, xlab = "Number of topics", ylab = "Mean of log held-out perplexity from 10-fold cross-validation") + geom_line() + ggtitle("Results from held-out perplexity from 10-fold cross-validation")
ggsave("logperplexity_results.png", device = "png")


qplot(seq(1,75,1), mean_topic_distr, xlab = "Topic number", ylab = "Mean proportion of documents (0.01 = 1%)") + geom_point() + ggtitle("Mean topic distribution over documents with 75 topics")
ggsave("topicdistr.png", device = "png")

save.image("full_tm_workspace.RData")
