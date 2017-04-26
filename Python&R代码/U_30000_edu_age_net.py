#!/usr/bin/python
#-*-coding:utf-8-*-
import numpy as np
import pandas as pd
from pandas import DataFrame

tmp_arr=np.loadtxt(r'D:\pythonCode\output_data\U_30000_mxk.txt',delimiter=',')
label=np.loadtxt(r'D:\pythonCode\output_data\label_20_30000.txt',delimiter=',')
arr=np.c_[tmp_arr,label,label,label]
row,col=np.shape(arr)

my_fmt=['%.9f','%.9f','%.9f','%.9f','%.9f','%.9f','%.9f','%d']

#edu-7,age-8,net-9
for k in range(row):#edu-7
    tmp=arr[k,7]
    if tmp in [1,5,8,10,12,13,17]: #high
        arr[k,7]=0
    elif  tmp in [0,4,9,6,19]: #medium
        arr[k,7]=1
    elif tmp in [2,3,7,11,14,15,16,18]: #low
        arr[k,7]=2
    else: arr[k,7]=-1

#edu-7,age-8,net-9
for k in range(row):#age-8
    tmp=arr[k,8]
    if tmp in [5,6]: #high
        arr[k,8]=0
    elif  tmp in [2,3,8,9,10,11,14]: #medium
        arr[k,8]=1
    elif tmp in [7,16,15,18]: #low
        arr[k,8]=2
    else: arr[k,8]=-1
    
#edu-7,age-8,net-9
for k in range(row):#net-9
    tmp=arr[k,9]
    if tmp in [1,8,9,10,11,12,13,17,19]: #high
        arr[k,9]=0
    elif  tmp in [0,7,15,16,18]: #medium
        arr[k,9]=1
    elif tmp in [1,2,5,14]: #low
        arr[k,9]=2
    else: arr[k,9]=-1



label_edu=arr[:,7]
arr_edu=arr[:,[0,1,2,3,4,5,6,7]]
arr_edu=arr_edu[label_edu!=-1]
#arr_edu=np.c_[arr_edu[:,7],arr_edu[:,:7]]
np.savetxt(r'D:\pythonCode\output_data\arr_edu.txt',arr_edu,fmt=my_fmt,delimiter=',')

label_age=arr[:,8]
arr_age=arr[:,[0,1,2,3,4,5,6,8]]
arr_age=arr_age[label_age!=-1]
np.savetxt(r'D:\pythonCode\output_data\arr_age.txt',arr_age,fmt=my_fmt,delimiter=',')

label_net=arr[:,9]
arr_net=arr[:,[0,1,2,3,4,5,6,9]]
arr_net=arr_net[label_net!=-1]
np.savetxt(r'D:\pythonCode\output_data\arr_net.txt',arr_net,fmt=my_fmt,delimiter=',')

###########################
data_edu=arr[:,:7]
df_edu0=DataFrame(data_edu[label_net==0])
df_edu1=DataFrame(data_edu[label_net==1])
df_edu2=DataFrame(data_edu[label_net==2])
print df_edu0.describe().ix[['mean','min','max']]
print df_edu1.describe().ix[['mean','min','max']]
print df_edu2.describe().ix[['mean','min','max']]
#####################################