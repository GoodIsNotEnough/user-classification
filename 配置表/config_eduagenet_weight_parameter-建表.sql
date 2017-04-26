load data local inpath '/data1/shell/data_tool/tmp/config_eduagenet_weight_parameter.csv' 
overwrite into table config_eduagenet_weight_parameter;

CREATE TABLE config_eduagenet_weight_parameter
(attribute STRING,
weight_edu FLOAT,
weight_age FLOAT,
weight_net FLOAT)
comment "V_nxk*Sigma_kxk.I*weight"
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;