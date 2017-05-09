-- Create a tmp table
CREATE TABLE tmp_union_idl_user_eduagenet_level_agg
( mobile_no STRING,
  score_edu FLOAT,
  level_edu INT,
  score_age FLOAT,
  level_age INT,
  score_net FLOAT,
  level_net INT
  )
comment "level: 0=high 1=medium 2=low"
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

-- union online and offline data and insert into the new tmp table
INSERT INTO tmp_union_idl_user_eduagenet_level_agg
SELECT
t2.mobile_no,
t2.score_edu,
t2.level_edu,
t2.score_age,
t2.level_age,
t2.score_net,
t2.level_net
FROM 
    (SELECT 
    t1.mobile_no,
    t1.score_edu,
    t1.level_edu,
    t1.score_age,
    t1.level_age,
    t1.score_net,
    t1.level_net,
    row_number() over (PARTITION BY t1.mobile_no ORDER BY t1.ds desc) AS rn
    FROM
        (SELECT 
        mobile_no,
        score_edu,
        level_edu,
        score_age,
        level_age,
        score_net,
        level_net,
        ds
        FROM idl_user_eduagenet_level_agg
        WHERE ds='2017-05-06'
        UNION ALL
        SELECT
        mobile_no,
        score_edu,
        level_edu,
        score_age,
        level_age,
        score_net,
        level_net,
        ds
        FROM tmp_idl_user_eduagenet_level_agg
        ) t1
    ) t2
WHERE t2.rn=1;

-- delete the latest partition and insert the union data
ALTER TABLE idl_user_eduagenet_level_agg DROP PARTITION(ds = "2017-05-06" );
INSERT INTO idl_user_eduagenet_level_agg PARTITION (ds="2017-05-06")
SELECT 
mobile_no,
score_edu,
level_edu,
score_age,
level_age,
score_net,
level_net
FROM tmp_union_idl_user_eduagenet_level_agg;