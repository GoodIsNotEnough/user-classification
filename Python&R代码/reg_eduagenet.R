setwd("D:\\pythonCode\\output_data")
p=read.table('arr_age.txt',header=F,sep=",",col.names=c("A","B","C","D","E","F","G","type"))
summary(p)
library(MASS)
value_type.plr <- polr(formula = as.ordered(type) ~ A + B + C + D + E + F + G,data = p)
value_type.plr
summary(value_type.plr)