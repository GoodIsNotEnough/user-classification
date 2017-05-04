CREATE TABLE if not exists tmp_idl_user_eduagenet_shopping_subroot_tmp
(
mobile_no     STRING,             
subroot_num   INT,                
subroot_map   MAP<STRING,STRING>  
) 
comment "shopping_subroot"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
COLLECTION ITEMS TERMINATED BY '\073'
MAP KEYS TERMINATED BY '\072'
STORED AS TEXTFILE;

INSERT INTO tmp_idl_user_eduagenet_shopping_subroot_tmp PARTITION (ds)
SELECT
mobile_no,  
subroot_num,
subroot_map,
CAST(date_add("2017-01-01",CAST(substring(mobile_no,-2,2) AS INT)) AS STRING) AS ds
FROM
    (SELECT
    t0.mobile_no,  
    coalesce(t4.subroot_num,0) AS subroot_num,
    t4.subroot_map, 
    row_number()over(partition BY t0.mobile_no ORDER BY t4.subroot_num DESC) AS ranks
    FROM
        (SELECT
        mobile_raw,	
        mobile_no	
        FROM idl_user_mobile_initial_agg
        WHERE ds='2017-04-20'
        ) t0
    LEFT JOIN
        (SELECT
        t3.mobile_raw, 
        count(t3.subroot_cid) subroot_num,
        str_to_map(concat_ws("\073",collect_set(concat_ws("\072",CAST(t3.subroot_cid AS STRING),CAST(t3.order_num AS STRING)))),"\073","\072") AS subroot_map
        FROM 
            (SELECT
            t1.mobile_raw,               
            t2.subroot_cid,              
            sum(t1.tid_num) AS order_num 
            FROM 
                (SELECT 
                mobile_raw, 
                cid,        
                tid_num     
                FROM idl_limao_user_cid_agg
                WHERE ds='2017-04-20'
                ) t1
                LEFT JOIN
                (SELECT 
                cid,        
                subroot_cid 
                FROM idl_limao_cid_dim
                WHERE ds='2017-04-20'
                ) t2
                ON t1.cid=t2.cid
                WHERE t2.cid IS NOT NULL
                group by t1.mobile_raw,t2.subroot_cid
            ) t3
          group by t3.mobile_raw
          ) t4
    ON t0.mobile_raw=t4.mobile_raw
    WHERE t4.mobile_raw IS NOT NULL
    ) t
WHERE ranks=1;

      
