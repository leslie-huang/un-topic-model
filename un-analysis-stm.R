# Leslie Huang

### Set up the workspace
rm(list=ls())
setwd("/Users/lesliehuang/un-analysis/")

set.seed(1234)

libraries <- c("foreign", "utils", "dplyr", "devtools", "quanteda", "ggplot2", "topicmodels", "stm", "lda", "LDAvis", "jsonlite", "stringi", "stmBrowser")
lapply(libraries, require, character.only=TRUE)

# Load data and limit to non empty texts
raw_df <- read.csv("../un-db/ungd-csv.csv", na.strings = c("", "NaN", "NA"), stringsAsFactors = FALSE)
df <- subset(raw_df, !is.na(text))

# Construct corpus, dfm
un_corpus <- corpus(df$text, docnames = df$filename)
docvars(un_corpus, field = c("country", "year")) <- c(df$country, df$year) 

summary(un_corpus)

un_dfm <- dfm(un_corpus, stem = TRUE, tolower = TRUE, remove_punct = TRUE, remove_numbers = TRUE, remove_url = TRUE, remove = stopwords("english"))

# Remove infrequent words
un_dfm <- dfm_trim(un_dfm, min_docfreq = 0.005)

####################################################################################
####################################################################################
# Convert to STM format

dfm_docvars <- select(df, country, year)

un_stm <- convert(un_dfm, to = "stm", docvars = dfm_docvars)

# Prep the metadata as numeric and categorial vars respectively
un_stm$meta$year <- as.numeric(un_stm$meta$year)
un_stm$meta$country <- as.factor(un_stm$meta$country)

# The vocab and metadata are available here
un_stm$vocab
un_stm$meta


save.image("un_stm_img.RData")
