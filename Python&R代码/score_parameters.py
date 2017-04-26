#!/usr/bin/python
#-*-coding:utf-8-*-
import numpy as np
import pandas as pd
from numpy import *

k=7
weight_edu=[644.48, 293.47,-84.69,514.95,113.19,110.54,-463.90]
weight_edu=mat(weight_edu).T
weight_age=[-463.18,-108.44,174.08,267.76,29.75,407.66,33.02]
weight_age=mat(weight_age).T
weight_net=[424.5,349.8,-298.3,305.0,290.5,-134.8,-265.6]
weight_net=mat(weight_net).T

Sigma_30000=np.loadtxt(r'D:\pythonCode\output_data\Sigma_30000.txt',delimiter=',') 
Sig7=mat(eye(k)*Sigma_30000[:k])
VT_nxn=np.load(r'D:\pythonCode\output_data\VT_30000.npy')
V_nxk=VT_nxn[:k,:].T #np.shape(V_nxk)
weight_edu=V_nxk*Sig7.I*weight_edu
weight_age=V_nxk*Sig7.I*weight_age
weight_net=V_nxk*Sig7.I*weight_net

data=pd.read_csv(r'D:\pythonCode\clustering\df_30000.csv')
row,col=data.shape
column_names=data.columns[1:]
print len(column_names),np.shape(weight_net)
fout=open(r'D:\pythonCode\clustering\tmp_kgs_score_parameter.csv','w')
for k in range(len(column_names)):
    line='%s,%g,%g,%g\n'%(column_names[k],weight_edu[k],weight_age[k],weight_net[k])
    fout.write(line)   
fout.close()   
#
#Sig7=np.loadtxt(r'D:\pythonCode\output_data\Sigma_kxk.txt',delimiter=',') 
#np.savetxt(r'D:\pythonCode\clustering\config_normalization.txt',arr,delimiter=',')
    
    