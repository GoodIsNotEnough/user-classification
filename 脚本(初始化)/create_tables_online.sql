-- 线上跑的初始化表
CREATE TABLE if not exists tmp_idl_user_eduagenet_email_tmp
(
mobile_no               STRING,
email_server_list       ARRAY<STRING>,
job_list                ARRAY<STRING>,
overseas_list           ARRAY<STRING>,
qq_length               INT, 
is_vip                  INT, 
is_number	            INT 
) 
comment "email domain and its aggregation"
PARTITIONED BY (ds STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
COLLECTION ITEMS TERMINATED BY '\073'
STORED AS TEXTFILE;

CREATE TABLE if not exists tmp_idl_user_eduagenet_shopping_behavior_tmp 
(
mobile_no               STRING COMMENT '手机号码',
total_pay	            FLOAT  COMMENT '所有订单的价格',
avg_item                FLOAT  COMMENT '衰减的购买物品的平均价格',
tid_sum	                INT    COMMENT '订单总数',
sf_sum	                INT    COMMENT '用顺丰快递的订单数',
high_sum	            INT    COMMENT '购买物品均价超过物品种类均价66%的订单数量',
middle_sum	            INT    COMMENT '购买物品均价位于物品种类均价33%到66%的订单数量',
low_sum	                INT    COMMENT '购买物品均价低于物品种类均价33%的订单数量',
receivers	            INT    COMMENT '历史收件人数',
seller_sum	            INT    COMMENT '店铺的数量',
phone_sum	            INT    COMMENT '手机下单的订单数量',
pc_sum	                INT    COMMENT 'PC下单的订单数量',
morning_sum	            INT    COMMENT '早上的订单数',
afternoon_sum	        INT    COMMENT '下午的订单数',
evening_sum	            INT    COMMENT '晚上的订单数',
midnight_sum	        INT    COMMENT '半夜的订单数',
workday_sum	            INT    COMMENT '工作日的订单数'
) 
comment "shopping_behavior"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

CREATE TABLE tmp_idl_user_eduagenet_data_union_tmp
( mobile_no STRING,
  attribute STRING,
  attribute_value STRING)
comment "user info including: shopping behavior,emials,occupation,registration"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

CREATE TABLE tmp_idl_user_eduagenet_level_agg
( mobile_no string,
  score_edu FLOAT,
  level_edu INT,
  score_age FLOAT,
  level_age INT,
  score_net FLOAT,
  level_net INT
  )
comment "level: 0=high 1=medium 2=low"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;
