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

par(mfrow=c(1,1))
plot.new()
png("tuning_plot_20_100.png", width = 1500, height = 1000)
tuning_plot <- FindTopicsNumber_plot(ldatuning_20_100[, c(1, 3:5)])
# exclude Griffiths because it's NA
dev.off()

ldatuning_by5 <- dplyr::filter(ldatuning_results, grepl("5$", topics) | grepl("0$", topics))
png("tuning_plot_by5.png", width = 1500, height = 1000)
tuning_plot <- FindTopicsNumber_plot(ldatuning_by5[, c(1, 3:5)]) # exclude Griffiths because it's NA
dev.off()


# Plot the results from 10-fold heldout perplexity
qplot(seq(40,90,1), combined_perplexity_results$mean_log, xlab = "Number of topics", ylab = "Mean of log held-out perplexity") + geom_line() + ggtitle("Results from held-out perplexity from 10-fold cross-validation")
ggsave("logperplexity_results.png", device = "png")

# Topic mean with confidence intervals

summary_stats <- data.frame(matrix(nrow = 75, ncol = 5))
colnames(summary_stats) <- c("mean", "sd", "se", "ci_lower", "ci_upper")

for (i in 1:ncol(topic_distr_over_docs)) {
  topic_mean <- mean(topic_distr_over_docs[,i])
  sd <- sd(topic_distr_over_docs[,i])
  se <- 1.96 * sd(topic_distr_over_docs[,i]/sqrt(length(topic_distr_over_docs[,i])))
  ttest <- t.test(topic_distr_over_docs[,i], conf.level = 0.95)
  conf_lower <- ttest$conf.int[1]
  conf_upper <- ttest$conf.int[2]
  
  summary_stats[i, ] <- c(topic_mean, sd, se, conf_lower, conf_upper)
  
}

# Plot mean with CI
pd <- position_dodge(0.1)
ggplot(summary_stats, aes(x = 1:75, y = mean)) +
  xlab("Topic number (no substantive meaning)") + 
  ylab("Mean proportion (out of 1.0)") + 
geom_errorbar(data = summary_stats, aes(ymin = mean - se, ymax = mean + se), width = 0.2, position = pd) +
    geom_point(position = pd) + ggtitle("Mean topic distribution over documents, 95% CI")
ggsave("topicdistr.png", device = "png")

# # old plot of just means
# qplot(seq(1,75,1), mean_topic_distr, xlab = "Topic number", ylab = "Mean proportion (0.01 = 1%)") + geom_point() + ggtitle("Mean topic distribution over documents with 75 topics")
# ggsave("topicdistr.png", device = "png")

# get summary stats
mean(tab$freq)
sd(tab$freq)

mean(ntoken(un_dfm))
sd(ntoken(un_dfm))
mean(ntype(un_dfm))
sd(ntype(un_dfm))


save.image("full_tm_workspace.RData")
