#!/usr/bin/python
#-*-coding:utf-8-*-
import numpy as np
import pandas as pd
from sklearn import preprocessing
from sklearn.cluster import KMeans

def find_k_dim(arr):
    arr=arr**2
    total=sum(arr)
    arr=arr.cumsum()
    threshold=0.9*total
    for index,item in enumerate(arr):
        if item>=threshold:
            return index
            break

sigma = np.load(r'/home/kangguosheng/python/Sigma_30000.npy')
k=find_k_dim(sigma)
print 'k=%d' % k

#load data and normalization
X_train=np.load(r'/home/kangguosheng/python/U_30000.npy')
min_max_scaler = preprocessing.MinMaxScaler()
X_train_minmax = min_max_scaler.fit_transform(X_train[:,:k+1])

# K-Means clustering
kmeans = KMeans(n_clusters=20, random_state = 2,init='k-means++')
kmeans.fit_predict(X_train_minmax)
print kmeans.labels_ #打印类标签

#将标签输入到文件
fout=open(r'/home/kangguosheng/python/label_20_30000.txt','w')
for label in kmeans.labels_:
    fout.write(str(label)+'\n')
   
fout.close()
