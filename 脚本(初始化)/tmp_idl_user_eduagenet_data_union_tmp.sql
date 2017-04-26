ALTER TABLE tmp_idl_user_eduagenet_data_union_tmp DROP PARTITION(ds="{p0}" );
INSERT INTO tmp_idl_user_eduagenet_data_union_tmp PARTITION (ds="{p0}")
SELECT
mobile_no,
attribute,
attribute_value
FROM
    (SELECT 
    mobile_no, 
    str_to_map(concat_ws("\073",registration_years_str,occupation_str,home_address_str,work_address_str),"\073","\072") AS attribute_map
    FROM 
        (SELECT
        mobile_no, 
        CASE  WHEN registration_years>0 and registration_years<1 THEN concat_ws('\072', 'registration_years_type1','1')
              WHEN registration_years>=1 and registration_years<5 THEN concat_ws('\072', 'registration_years_type2','1')
              WHEN registration_years>=5 and registration_years<10 THEN concat_ws('\072', 'registration_years_type3','1')
              WHEN registration_years>=10 and registration_years<15 THEN concat_ws('\072', 'registration_years_type4','1')
              WHEN registration_years>=15 THEN concat_ws('\072', 'registration_years','type5','1')
              ELSE concat_ws('\072', 'registration_years_type0','1')
        END AS registration_years_str,
        concat_ws('\072', concat_ws('_','occupation',CAST(IF(ISNULL(occupation),'NULL',occupation) AS STRING)),'1') AS occupation_str,
        concat_ws('\072', IF(ISNULL(home_address),'home_address_NULL','home_address'),CAST(IF(ISNULL(home_address),'1',home_address) AS STRING)) AS home_address_str,
        concat_ws('\072', IF(ISNULL(work_address),'work_address_NULL','work_address'),CAST(IF(ISNULL(work_address),'1',work_address) AS STRING)) AS work_address_str
        FROM tmp_idl_user_eduagenet_registration_occupation_tmp
        WHERE ds="{p0}"
        ) t1
   ) t2
LATERAL VIEW OUTER explode(attribute_map) mytable AS attribute,attribute_value
UNION ALL
SELECT
mobile_no,
IF(ISNULL(subroot_num),'subroot_num_NULL','subroot_num') AS attribute,
CAST(IF(ISNULL(subroot_num),'1',subroot_num) AS STRING) AS attribute_value
FROM tmp_idl_user_eduagenet_shopping_subroot_tmp
WHERE ds="{p0}"
UNION ALL
SELECT
mobile_no, 
concat_ws('_','subroot_map',CAST(IF(ISNULL(attribute0),'NULL',attribute0) AS STRING)) AS attribute,
CAST(IF(ISNULL(attribute_value0),'1',attribute_value0) AS STRING) AS attribute_value
FROM tmp_idl_user_eduagenet_shopping_subroot_tmp
LATERAL VIEW OUTER explode(subroot_map) mytable0 AS attribute0,attribute_value0
WHERE ds="{p0}"
UNION ALL
SELECT
mobile_no,
attribute,
attribute_value
FROM
    (SELECT
    mobile_no, 
    str_to_map(concat_ws("\073",qq_length_str,is_vip_str,is_number_str),"\073","\072") AS attribute_map
    FROM 
        (SELECT
        mobile_no, 
        concat_ws('\072', concat_ws('_','qq_length',CAST(qq_length AS STRING)),'1')  AS qq_length_str,
        concat_ws('\072', 'is_vip',CAST(is_vip AS STRING)) AS is_vip_str,
        concat_ws('\072', 'is_number',CAST(is_number AS STRING)) AS is_number_str     
        FROM tmp_idl_user_eduagenet_email_tmp
        WHERE ds="{p0}"
        ) t1
    ) t2
LATERAL VIEW OUTER explode(attribute_map) mytable1 as attribute,attribute_value
UNION ALL
SELECT
mobile_no, 
concat_ws('_','email_server',CAST(IF(ISNULL(email_server),'NULL',email_server) AS STRING)) AS attribute,
'1' AS attribute_value
FROM tmp_idl_user_eduagenet_email_tmp
LATERAL VIEW OUTER explode(email_server_list) mytable2 as email_server
WHERE ds="{p0}"
UNION ALL
SELECT
mobile_no, 
concat_ws('_','email_server',CAST(IF(ISNULL(job),'NULL',job) AS STRING)) AS attribute,
'1' AS attribute_value
FROM tmp_idl_user_eduagenet_email_tmp
LATERAL VIEW OUTER explode(job_list) mytable3 as job
WHERE ds="{p0}"
UNION ALL
SELECT
mobile_no, 
concat_ws('_','email_server',CAST(IF(ISNULL(overseas),'NULL',overseas) AS STRING)) AS attribute,
'1' AS attribute_value
FROM tmp_idl_user_eduagenet_email_tmp
LATERAL VIEW OUTER explode(overseas_list) mytable4 as overseas
WHERE ds="{p0}"
UNION ALL
SELECT
mobile_no,
attribute,
attribute_value
FROM
    (SELECT
    mobile_no, 
    str_to_map(concat_ws("\073",total_pay_str,avg_item_str,
    tid_sum_str,sf_sum_str,high_sum_str,middle_sum_str,low_sum_str,
    receivers_str,seller_sum_str,phone_sum_str,pc_sum_str,morning_sum_str,
    afternoon_sum_str,evening_sum_str,midnight_sum_str,workday_sum_str),"\073","\072") AS attribute_map
    FROM 
        (SELECT
        mobile_no, 
        concat_ws('\072', IF(ISNULL(total_pay),'total_pay_NULL','total_pay'),CAST(IF(ISNULL(total_pay),'1',total_pay) AS STRING)) AS total_pay_str,
        concat_ws('\072', IF(ISNULL(avg_item),'avg_item_NULL','avg_item'),CAST(IF(ISNULL(avg_item),'1',avg_item) AS STRING)) AS avg_item_str,
        concat_ws('\072', IF(ISNULL(tid_sum),'tid_sum_NULL','tid_sum'),CAST(IF(ISNULL(tid_sum),'1',tid_sum) AS STRING)) AS tid_sum_str,
        concat_ws('\072', IF(ISNULL(sf_sum),'tid_sum_NULL','sf_sum'),CAST(IF(ISNULL(sf_sum),'1',sf_sum) AS STRING)) AS sf_sum_str,
        concat_ws('\072', IF(ISNULL(high_sum),'high_sum_NULL','high_sum'),CAST(IF(ISNULL(high_sum),'1',high_sum) AS STRING)) AS high_sum_str,
        concat_ws('\072', IF(ISNULL(middle_sum),'middle_sum_NULL','middle_sum'),CAST(IF(ISNULL(middle_sum),'1',middle_sum) AS STRING)) AS middle_sum_str,
        concat_ws('\072', IF(ISNULL(low_sum),'low_sum_NULL','low_sum'),CAST(IF(ISNULL(low_sum),'1',low_sum) AS STRING)) AS low_sum_str,
        concat_ws('\072', IF(ISNULL(receivers),'receivers_NULL','receivers'),CAST(IF(ISNULL(receivers),'1',receivers) AS STRING)) AS receivers_str,
        concat_ws('\072', IF(ISNULL(seller_sum),'seller_sum_NULL','seller_sum'),CAST(IF(ISNULL(seller_sum),'1',seller_sum) AS STRING)) AS seller_sum_str,
        concat_ws('\072', IF(ISNULL(phone_sum),'phone_sum_NULL','phone_sum'),CAST(IF(ISNULL(phone_sum),'1',phone_sum) AS STRING)) AS phone_sum_str,
        concat_ws('\072', IF(ISNULL(pc_sum),'pc_sum_NULL','pc_sum'),CAST(IF(ISNULL(pc_sum),'1',pc_sum) AS STRING)) AS pc_sum_str,
        concat_ws('\072', IF(ISNULL(morning_sum),'morning_sum_NULL','morning_sum'),CAST(IF(ISNULL(morning_sum),'1',morning_sum) AS STRING)) AS morning_sum_str,
        concat_ws('\072', IF(ISNULL(afternoon_sum),'afternoon_sum_NULL','afternoon_sum'),CAST(IF(ISNULL(afternoon_sum),'1',afternoon_sum) AS STRING)) AS afternoon_sum_str,
        concat_ws('\072', IF(ISNULL(evening_sum),'evening_sum_NULL','sevening_sum'),CAST(IF(ISNULL(evening_sum),'1',evening_sum) AS STRING)) AS evening_sum_str,
        concat_ws('\072', IF(ISNULL(midnight_sum),'midnight_sum_NULL','midnight_sum'),CAST(IF(ISNULL(midnight_sum),'1',midnight_sum) AS STRING)) AS midnight_sum_str,
        concat_ws('\072', IF(ISNULL(workday_sum),'workday_sum_NULL','workday_sum'),CAST(IF(ISNULL(workday_sum),'1',workday_sum) AS STRING)) AS workday_sum_str
        FROM tmp_idl_user_eduagenet_shopping_behavior_tmp
        WHERE ds="{p0}"
        ) t1
    ) t2
LATERAL VIEW OUTER explode(attribute_map) mytable5 as attribute,attribute_value;



