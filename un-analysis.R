# Leslie Huang

### Set up the workspace
rm(list=ls())
setwd("/Users/lesliehuang/un-analysis/")

set.seed(1234)

libraries <- c("foreign", "utils", "dplyr", "devtools", "quanteda", "ggplot2", "topicmodels", "stm", "lda", "LDAvis", "jsonlite", "stringi", "stmBrowser")
lapply(libraries, require, character.only=TRUE)

raw_df <- read.csv("../un-db/ungd-csv.csv", na.strings = c("", "NaN", "NA"), stringsAsFactors = FALSE)

df <- subset(raw_df, !is.na(text))

un_corpus <- corpus(df$text, docnames = df$filename)
docvars(un_corpus, field = c("country", "year")) <- c(df$country, df$year) 

summary(un_corpus)

un_dfm <- dfm(un_corpus, stem = TRUE, tolower = TRUE, remove_punct = TRUE, remove_numbers = TRUE, remove_url = TRUE, remove = stopwords("english"))

un_dfm <- dfm_trim(un_dfm, min_docfreq = 0.005)
# write.csv(un_dfm, file = "un_dfm.csv", fileEncoding = "UTF-8")

# Choose k
result <- FindTopicsNumber(un_dfm, topics = seq(20, 100, by = 20), metrics = c("Griffiths2004", "CaoJuan2009", "Arun2010", "Deveaud2014"), mc.cores = 7L, verbose = TRUE)

FindTopicsNumber_plot(result)

result2 <- FindTopicsNumber(un_dfm, topics = seq(40, 80, by = 5), metrics = c("Griffiths2004", "CaoJuan2009", "Arun2010", "Deveaud2014"), mc.cores = 7L, verbose = TRUE)

result3 <- FindTopicsNumber(un_dfm, topics = seq(50, 64, by = 2), metrics = c("Griffiths2004", "CaoJuan2009", "Arun2010", "Deveaud2014"), mc.cores = 7L, verbose = TRUE)


# Run the topic model
model <- LDA(un_dfm, k = 58, control = list(seed = 1234))

save.image("un_img.RData")
