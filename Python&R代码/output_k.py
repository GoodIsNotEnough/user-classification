#!/usr/bin/python
# -*-coding:utf-8-*-
import numpy as np
import pandas as pd
from sklearn import preprocessing
from sklearn.cluster import KMeans


def find_k_dim(arr):
    arr0=arr
    arr = arr ** 2
    total = sum(arr)
    arr = arr.cumsum()
    threshold = 0.9 * total
    for index, item in enumerate(arr):
        if item >= threshold:
            print index
            print arr0[index]
            return index
            break


sigma = np.load(r'/home/kangguosheng/python/Sigma_30000.npy')
k = find_k_dim(sigma)
print 'k=%d' % k

U_30000=np.load(r'/home/kangguosheng/python/U_30000.npy')
U_30000_mxk=U_30000[:,:k+1]
np.savetxt(r'/home/kangguosheng/python/U_30000_mxk.txt',U_30000_mxk,delimiter=',')