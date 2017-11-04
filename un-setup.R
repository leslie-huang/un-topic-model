# Leslie Huang

# Run this first to setup workspace with all necessary data

### Set up the workspace
rm(list=ls())
setwd("/Users/lesliehuang/un-analysis/")

set.seed(1234)

libraries <- c("foreign", "utils", "dplyr", "plyr", "devtools", "quanteda", "stringi")
lapply(libraries, require, character.only=TRUE)

raw_df <- read.csv("ungd-csv.csv", na.strings = c("", "NaN", "NA"), stringsAsFactors = FALSE)

df_full <- subset(raw_df, !is.na(text))

gd_speeches <- subset(df_full, is.na(sess_type))

gd_speeches <- dplyr::select(gd_speeches, c("ID", "country", "year", "speaker", "record_name", "text", "head_of_state", "speaker_notes", "filename"))

gd_speeches <- unique(gd_speeches)

# Just checking that the correct number of speeches are there
tab <- plyr::count(gd_speeches, c("country"))
tab <- dplyr::filter(tab, freq != 24)

xtab <- unclass(table(gd_speeches$country, gd_speeches$year))
xtab <- cbind(xtab, rowSums(xtab))
xtab_df <- as.data.frame(xtab, row.names = rownames(xtab))

#write.csv(gd_speeches, file = "un_corpus.csv", fileEncoding = "UTF-8")


# Make corpus and dfm
un_corpus <- corpus(gd_speeches$text, docnames = gd_speeches$filename)
docvars(un_corpus, field = c("country", "year")) <- c(gd_speeches$country, gd_speeches$year)

summary(un_corpus)

un_dfm <- dfm(un_corpus, stem = TRUE, tolower = TRUE, remove_punct = TRUE, remove_numbers = TRUE, remove_separators = TRUE, remove_url = TRUE, remove = stopwords("english"))

un_dfm <- dfm_trim(un_dfm, min_docfreq = 0.005, max_docfreq = .9)
#write.csv(un_dfm, file = "un_dfm.csv", fileEncoding = "UTF-8")

# Write quanteda DFM to topicmodels DFM
tm_dfm <- convert(un_dfm, to = "topicmodels")

save.image("un_base_workspace.RData")