ALTER TABLE tmp_idl_user_eduagenet_level_agg DROP PARTITION(ds="{p0}" );
INSERT INTO tmp_idl_user_eduagenet_level_agg PARTITION (ds="{p0}")
SELECT 
mobile_no,
score_edu,
IF(score_edu<0.00163121108,0,IF(score_edu<0.08979831464,1,2)) AS level_edu,
score_age,
IF(score_age<0.44739539242,0,IF(score_age<0.99676504479,1,2)) AS level_age,
score_net,
IF(score_net<0.02422610792,0,IF(score_net<0.55386515371,1,2)) AS level_net
FROM 
    (SELECT
    t3.mobile_no,
    EXP(SUM(t3.attribute_value*t4.weight_edu))/(1+EXP(SUM(t3.attribute_value*t4.weight_edu))) AS score_edu,
    EXP(SUM(t3.attribute_value*t4.weight_age))/(1+EXP(SUM(t3.attribute_value*t4.weight_age))) AS score_age,
    EXP(SUM(t3.attribute_value*t4.weight_net))/(1+EXP(SUM(t3.attribute_value*t4.weight_net))) AS score_net
    FROM 
        (SELECT
        t1.mobile_no, 
        t1.attribute,
        (t1.attribute_value-t2.att_min)/(t2.att_max-t2.att_min) AS attribute_value
        FROM 
            (SELECT
            mobile_no, 
            attribute,
            CAST(IF(ISNULL(attribute_value),0,attribute_value) AS FLOAT) AS attribute_value
            FROM tmp_idl_user_eduagenet_data_union_tmp
            WHERE ds="{p0}"
            )AS t1
        LEFT JOIN config_eduagenet_normalization_parameter AS t2
        On t1.attribute=t2.attribute
        WHERE t2.attribute IS NOT NULL
        ) t3
    LEFT JOIN config_eduagenet_weight_parameter t4
    ON t3.attribute=t4.attribute
    WHERE t4.attribute IS NOT NULL
    GROUP BY t3.mobile_no
    ) t5;

