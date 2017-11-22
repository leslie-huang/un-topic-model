
# coding: utf-8

# In[1]:

import lda
import nltk
from nltk.stem.snowball import SnowballStemmer
from nltk.corpus import stopwords
from nltk.tag import StanfordNERTagger
from nltk.tokenize import word_tokenize
import numpy as np
import os
import pandas as pd
import re
import sqlite3
from sklearn.feature_extraction.text import CountVectorizer
import sys


# In[2]:


conn = sqlite3.connect("/Users/lesliehuang/un-db/my-dbs.db")
c = conn.cursor()

df = pd.read_sql("SELECT * FROM ungd", conn)

c.close()


# In[3]:


df = df[df["text"] != ""]
df = df.reset_index(drop = True)

titles = df["filename"]



# In[4]:

# Set up stemming
stemmer = SnowballStemmer("english")
nltk.download("stopwords")

analyzer = CountVectorizer().build_analyzer()


# define stemmer and stopword/number remover
# because stopwords can't be removed in CountVectorizer() if custom analyzer is passed
def stemmed_words(text):
    return (stemmer.stem(w) for w in analyzer(text) if (w not in stopwords.words("english") and not w.isdigit()))


# In[5]:

# Make the dfm
vectorizer = CountVectorizer(lowercase = True, min_df = 0.005, analyzer = stemmed_words)

X = vectorizer.fit_transform(df["text"])

vocab = vectorizer.get_feature_names()


# In[6]:

# Display most common words

#np.array(vocab)[np.argsort(X.toarray().sum(axis = 0))]

# indices of word frequencies in order
ranking = np.argsort(X.toarray().sum(axis=0))[::-1]

# Most frequently used words
print(np.array(vocab)[ranking][1:100])


# In[7]:

# Least frequently used words
print(np.array(vocab)[ranking][-100:])


# In[8]:


# Run the model
k = 58

model = lda.LDA(n_topics = k, n_iter = 500, random_state = 1)
model.fit(X)

topic_words = model.topic_word_
doc_topic = model.doc_topic_


# In[9]:

# display some stuff
n = 50

for i, topic_dist in enumerate(topic_words):
    top_words = np.array(vocab)[np.argsort(topic_dist)][:-(k+1):-1]
    print("Topic {}: ".format(i))
    print("{}\n".format(" ".join(top_words)))

for i in range(n):
    print("{} -- top topic: {}".format(
                                        titles[i], 
                                        doc_topic[i].argmax()
                                        )
        )


# In[10]:

model_40 = lda.LDA(n_topics = 40, n_iter = 500, random_state = 1)
model_40.fit(X)

topic_words40 = model_40.topic_word_
doc_topic40 = model_40.doc_topic_


# In[11]:

# display some stuff
n = 50

for i, topic_dist in enumerate(topic_words40):
    top_words = np.array(vocab)[np.argsort(topic_dist)][:-(k+1):-1]
    print("Topic {}: ".format(i))
    print("{}\n".format(" ".join(top_words)))

for i in range(n):
    print("{} -- top topic: {}".format(
                                        titles[i], 
                                        doc_topic40[i].argmax()
                                        )
        )

