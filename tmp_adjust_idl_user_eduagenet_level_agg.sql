-- Create a tmp table
CREATE TABLE tmp_adjust_idl_user_eduagenet_level_agg
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

INSERT INTO tmp_adjust_idl_user_eduagenet_level_agg
SELECT 
mobile_no,
score_edu,
IF(score_edu<0.15690,0,IF(score_edu<0.404511,1,2)) AS level_edu,
score_age,
IF(score_age<0.5000461,0,1) AS level_age,
score_net,
IF(score_net<0.30,0,IF(score_net<0.49989798,1,2)) AS level_net
FROM idl_user_eduagenet_level_agg
WHERE ds = '2017-05-08';

ALTER TABLE idl_user_eduagenet_level_agg DROP PARTITION (ds="2017-05-08" );
INSERT INTO idl_user_eduagenet_level_agg PARTITION (ds="2017-05-08")
SELECT 
mobile_no,
score_edu,
level_edu,
score_age,
level_age,
score_net,
level_net
FROM tmp_adjust_idl_user_eduagenet_level_agg;