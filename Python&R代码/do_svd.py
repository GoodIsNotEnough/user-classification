#!/usr/bin/python
#-*-coding:utf-8-*-
import numpy as np
import pandas as pd
import pprint
import pickle
from sklearn import preprocessing

def find_k_dim(arr):
    arr=arr**2
    total=sum(arr)
    arr=arr.cumsum()
    threshold=0.9*total
    for index,item in enumerate(arr):
        if item>=threshold:
            return index
            break

#准备df_50000.txt文件，删除文件头和第1列
print 'reading file ...'
tmp_arr=np.loadtxt(r'/home/kangguosheng/python/df_30000.txt',delimiter=',',skiprows=1) #(30000L, 1257L)
arr=tmp_arr[:,1:] #(30000L, 1256L)

print 'normalizing ...'
#Normalization
min_max_scaler = preprocessing.MinMaxScaler()
arr = min_max_scaler.fit_transform(arr)
np.save(r'/home/kangguosheng/python/arr_norm_30000.npy',arr)

print "---SVD started--"
U,Sigma,VT=np.linalg.svd(arr)
print "---SVD ended----"

np.savetxt(r'/home/kangguosheng/python/U_30000.txt',U,delimiter=',')
np.savetxt(r'/home/kangguosheng/python/Sigma_30000.txt',Sigma,delimiter=',')
np.savetxt(r'/home/kangguosheng/python/VT_30000.txt',VT,delimiter=',')

np.save(r'/home/kangguosheng/python/U_30000.npy',U)
np.save(r'/home/kangguosheng/python/Sigma_30000.npy',Sigma)
np.save(r'/home/kangguosheng/python/VT_30000.npy',VT)

print "---all finished----"


#output = open(r'E:\data\U_Sigma_VT.pkl', 'wb')
#pickle.dump((U,Sigma,VT), output) 
#output.close()
#(U,Sigma,VT)=np.load(r'E:\data\U_Sigma_VT.pkl')

#k=find_k_dim(Sigma)


