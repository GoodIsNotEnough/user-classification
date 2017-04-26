load data local inpath '/data1/shell/data_tool/tmp/config_eduagenet_normalization_parameter.csv' 
overwrite into table config_eduagenet_normalization_parameter;

CREATE TABLE config_eduagenet_normalization_parameter
(attribute STRING,
att_max FLOAT,
att_min FLOAT)
comment "data nornalization before svd"
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;