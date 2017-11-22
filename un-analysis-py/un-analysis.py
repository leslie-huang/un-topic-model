import lda
import nltk
from nltk.stem.snowball import SnowballStemmer
from nltk.corpus import stopwords
import numpy as np
import os
import pandas as pd
import re
import sqlite3
from sklearn.feature_extraction.text import CountVectorizer
import sys

conn = sqlite3.connect("../un-db/my-dbs.db")
c = conn.cursor()

df = pd.read_sql("SELECT * FROM ungd", conn)

c.close()

df = df[df["text"] != ""]
df = df.reset_index(drop = True)

titles = df["filename"]

# Set up stemming
stemmer = SnowballStemmer("english")
nltk.download("stopwords")

analyzer = CountVectorizer().build_analyzer()


# define stemmer and stopword remover
# because stopwords can't be removed in CountVectorizer() if custom analyzer is passed
def stemmed_words(text):
    return (stemmer.stem(w) for w in analyzer(text) if w not in stopwords.words("english"))

# Get the dfm
vectorizer = CountVectorizer(lowercase = True, min_df = 0.005, analyzer = stemmed_words)

X = vectorizer.fit_transform(df["text"])

vocab = vectorizer.get_feature_names()

# Run the model
model = lda.LDA(n_topics = 10, n_iter = 200, random_state = 1)
model.fit(X)

topic_words = model.topic_word_
doc_topic = model.doc_topic_

# display some stuff
n = 10

for i, topic_dist in enumerate(topic_words):
    top_words = np.array(vocab)[np.argsort(topic_dist)][:-(n+1):-1]
    print("Topic {}: ".format(i))
    print("{}\n".format(" ".join(top_words)))

for i in range(n):
    print("{} -- top topic: {}".format(
                                        titles[i], 
                                        doc_topic[i].argmax()
                                        )
        )