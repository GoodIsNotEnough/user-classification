#!/usr/bin/python
#-*-coding:utf-8-*-
import numpy as np
import pandas as pd

data=pd.read_csv(r'D:\pythonCode\clustering\df_30000.csv')
#data.describe()
row,col=data.shape
column_names=data.columns[1:]
fout=open(r'D:\pythonCode\clustering\config_eduagenet_normalization_parameter.csv','w')
for k in range(len(column_names)):
    line='%s,%g,%g\n'%(column_names[k],max(data[column_names[k]]),min(data[column_names[k]]))
    fout.write(line)
    
fout.close()    
#np.savetxt(r'D:\pythonCode\clustering\config_normalization.txt',arr,delimiter=',')
    
    