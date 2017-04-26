#!/usr/bin/python
# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd
from pandas import Series,DataFrame
import datetime
starttime = datetime.datetime.now()

def return_list(filepath): # read vip_email file to list
    fin=open(filepath)
    vip_email_list=[]
    for line in fin:
        vip_email_list.append(line.strip('\n'))
    fin.close()
    return vip_email_list
    
def is_map(str):
    if str==('{'+str.strip('{}')+'}'):
        return True
    else:
        return False
        
def is_array(str):   
    if str==('['+str.strip('[]')+']'):
        return True
    else:
        return False
        
def process_registration_years(str):
    if str=="NULL":
        column_name='registration_years_type0'
        return column_name
    try:
        years=float(str)
    except:
        print "ERROR:cannot transfer to float!!!"
    if 0<=years<=1:
        column_name='registration_years_type1'
    elif 1<years<=5:
        column_name='registration_years_type2'
    elif 5<years<=10:
        column_name='registration_years_type3'
    elif 10<years<=15:
        column_name='registration_years_type4'
    else:  #15<years
        column_name='registration_years_type5'
    return column_name

    
list_columns=['mobile_no','registration_years','occupation','home_address','work_address',\
'subroot_num','subroot_map','email_server_list','job_list','overseas_list','qq_length','is_vip',\
'is_number','total_pay','avg_item','tid_sum','sf_sum',\
'high_sum','middle_sum','low_sum','receivers','seller_sum','phone_sum','pc_sum',\
'midnight_num','afternoon_num','evening_num','midnight_sum','workday_num'] #
#len(list_columns)=26
default_columns=['mobile_no'] #
#len(default_columns)=1

#参数设置-----------------------------
row_num=30000
input_file=r'/home/kangguosheng/python/30000.csv'
output_file=r'/home/kangguosheng/python/df_30000.csv'
#--------------------------------------
email_file_path=r'/home/kangguosheng/python/email_list.txt' #ANSI编码
email_list=return_list(email_file_path)

col_num=len(default_columns)
df=DataFrame(np.zeros((row_num,col_num)),columns=default_columns)
#df=pd.read_csv(r'E:\data\df_50000.csv')
fin=open(input_file)
fin.readline() #先读第一行
for row,line in enumerate(fin):
    print "line %d is processing, %s has beed used. Please wait ..." % (row,(datetime.datetime.now() - starttime))
    line=line.strip('\n\r')
    line_list=line.split(',')
    #print line_list
    line_list.pop()#删除最后一个元素：分区列
    if len(line_list)!=len(list_columns):
        print "ERROR:number of columns is inconsistent with len(list_columns)!!!"
    for index,item in enumerate(line_list):
        if list_columns[index]=='registration_years': #类别属性取0/1
            column_name=process_registration_years(item)
            df.ix[row,column_name]=1
        elif list_columns[index]=='occupation': #类别属性取0/1
            column_name='occupation_'+item
            df.ix[row,column_name]=1
        elif list_columns[index]=='qq_length': #类别属性取0/1
            column_name="qq_length_"+item
            df.ix[row,column_name]=1
        elif is_map(item):  #map类型属性
            item=item.strip('{}')
            item_list=item.split(';')
            for dict_item in item_list:
                key=dict_item.split(':')[0]
                value=dict_item.split(':')[1]
                column_name=list_columns[index]+'_'+key
                df.ix[row,column_name]=value
        elif is_array(item): #array类型属性取0/1
            item=item.strip('[]')
            item_list=item.split(';')
            for array_item in item_list:
                if list_columns[index]=='email_server_list' and array_item not in email_list:
                    continue
                column_name=list_columns[index]+'_'+array_item
                df.ix[row,column_name]=1            
        elif item=="NULL": #NULL值作为一个类别取0/1
            column_name=list_columns[index]+'_'+item
            df.ix[row,column_name]=1
        else:
            try:
                column_name=list_columns[index]
                df.ix[row,column_name]=float(item)
            except:
                print item
                print row,column_name
                
df.fillna(0,inplace=True)
df=df.replace('null','0')
df.to_csv(output_file,index=False)
fin.close()

endtime = datetime.datetime.now()
print (endtime - starttime).seconds
print (endtime - starttime) #0:00:00.280797
