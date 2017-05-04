CREATE TABLE IF not exists tmp_idl_user_eduagenet_registration_occupation_tmp
(
mobile_no               STRING COMMENT '手机号码',
registration_years	    FLOAT  COMMENT 'limao账号注册年数',
occupation              STRING COMMENT '职业',
home_address            INT    COMMENT '是否家庭住址',
work_address            INT    COMMENT '是否工作住址'
) 
comment "registration_years+occupation"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

INSERT INTO tmp_idl_user_eduagenet_registration_occupation_tmp PARTITION (ds)
SELECT 
t.mobile_no,
round(datediff(to_date(current_timestamp()),t.registrytime)/365,2) AS registration_years,
t.occupation,
t.home_address,
t.work_address,
CAST(date_add("2017-01-01",CAST(substring(t.mobile_no,-2,2) AS INT)) AS STRING) AS ds  
FROM
    (
    SELECT 
    t1.mobile_no,
    t2.registrytime,
    t3.occupation,
    t3.home_address,
    t3.work_address,
    row_number() over (PARTITION BY t1.mobile_no ORDER BY t2.registrytime DESC) AS rn  
    FROM 
        (SELECT mobile_no,limao_nick
        FROM ald_limao_receiver_agg
        WHERE ds='2017-04-20'
        ) t1
    LEFT JOIN 
        (SELECT limao_nick,registrytime
        FROM idl_limao_info_dim
        WHERE ds='2017-04-20'
        ) t2
    ON t1.limao_nick=t2.limao_nick
    LEFT JOIN 
        (SELECT 
        mobile_no,
        occupation,
        IF(updatedt_home IS NULL, 0, 1) home_address, 
        IF(updatedt_work IS NULL, 0, 1) work_address
        FROM idl_user_address_summar_agg
        WHERE ds='2017-04-20'
        ) t3
    ON t3.mobile_no=t1.mobile_no
    WHERE t2.limao_nick IS NOT NULL AND t3.mobile_no IS NOT NULL
    ) t
WHERE rn=1;
