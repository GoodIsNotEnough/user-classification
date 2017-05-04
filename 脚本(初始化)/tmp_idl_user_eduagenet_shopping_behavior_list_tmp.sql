CREATE TABLE if not exists tmp_idl_user_eduagenet_shopping_behavior_list_tmp
(
mobile_no               STRING COMMENT '手机号码',
total_pay	            FLOAT  COMMENT '所有订单的价格',
avg_item                FLOAT  COMMENT '衰减的购买物品的平均价格',
tid_sum	                INT    COMMENT '订单总数',
sf_sum	                INT    COMMENT '用顺丰快递的订单数',
high_sum	            INT    COMMENT '购买物品均价超过物品种类均价66%的订单数量',
middle_sum	            INT    COMMENT '购买物品均价位于物品种类均价33%到66%的订单数量',
low_sum	                INT    COMMENT '购买物品均价低于物品种类均价33%的订单数量',
receiver_list	        ARRAY<STRING> COMMENT '历史收件人和手机号',
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
COLLECTION ITEMS TERMINATED BY '\073'
STORED AS TEXTFILE;

INSERT INTO tmp_idl_user_eduagenet_shopping_behavior_list_tmp PARTITION (ds)
SELECT 
mobile_no,
total_pay,
avg_item,
tid_sum,
sf_sum,
high_sum,
middle_sum,
low_sum,
receivers AS receiver_list,
seller_sum,
phone_sum,
pc_sum,
morning_sum,
afternoon_sum,
evening_sum,
midnight_sum,
workday_sum,
CAST(date_add("2017-01-01",CAST(substring(mobile_no,-2,2) AS INT)) AS STRING) AS ds          
FROM
    (SELECT 
    mobile_no,
    total_pay,
    avg_item,
    tid_sum,
    sf_sum,
    high_sum,
    middle_sum,
    low_sum,
    receivers,
    seller_sum,
    phone_sum,
    pc_sum,
    morning_sum,
    afternoon_sum,
    evening_sum,
    midnight_sum,
    workday_sum,
    row_number() over (PARTITION BY t1.mobile_no ORDER BY t2.tid_sum desc) AS rn  
    from 
        (select mobile_no,limao_nick
        from ald_limao_receiver_agg
        where ds='2017-04-20'
        ) t1
    left join 
        (select *
        from idl_user_sens_agg
        where ds='2017-04-20'
        ) t2
    on t1.limao_nick=t2.buyer_nick
    where t2.buyer_nick is not null
    ) t3
where rn=1;
