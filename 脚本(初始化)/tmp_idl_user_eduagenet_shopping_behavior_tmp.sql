ALTER TABLE tmp_idl_user_eduagenet_shopping_behavior_tmp DROP PARTITION(ds="{p0}" );
INSERT INTO tmp_idl_user_eduagenet_shopping_behavior_tmp PARTITION (ds="{p0}")
SELECT
t1.mobile_no,
t1.total_pay,
t1.avg_item,
t1.tid_sum,
t1.sf_sum,
t1.high_sum,
t1.middle_sum,
t1.low_sum,
t2.receivers,
t1.seller_sum,
t1.phone_sum,
t1.pc_sum,
t1.morning_sum,
t1.afternoon_sum,
t1.evening_sum,
t1.midnight_sum,
t1.workday_sum	            
FROM 
    (SELECT *
     FROM tmp_idl_user_eduagenet_shopping_behavior_list_tmp
     WHERE ds="{p0}"
    )t1
LEFT JOIN
    (SELECT 
    mobile_no,
    size(collect_set(receiver)) AS receivers
    FROM tmp_idl_user_eduagenet_shopping_behavior_list_tmp
    LATERAL VIEW OUTER explode(receiver_list) mytable as receiver
    WHERE ds="{p0}" and length(receiver)>0
    GROUP BY mobile_no
    ) t2
on t1.mobile_no=t2.mobile_no
WHERE t2.mobile_no is not null;