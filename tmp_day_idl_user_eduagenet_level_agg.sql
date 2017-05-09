CREATE TABLE tmp_day_idl_user_eduagenet_level_agg
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

INSERT INTO tmp_day_idl_user_eduagenet_level_agg
SELECT 
mobile_no,
score_edu,
level_edu,
score_age,
level_age,
score_net,
level_net
FROM idl_user_eduagenet_level_agg
WHERE ds='2017-05-06';