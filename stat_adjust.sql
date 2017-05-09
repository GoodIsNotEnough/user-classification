-- gather statistical results
SELECT
sum(CASE WHEN score_edu>=0.0 AND score_edu<0.1 THEN 1 ELSE 0 END) edu_0_1,
sum(CASE WHEN score_edu>=0.1 AND score_edu<0.2 THEN 1 ELSE 0 END) edu_1_2,
sum(CASE WHEN score_edu>=0.2 AND score_edu<0.3 THEN 1 ELSE 0 END) edu_2_3,
sum(CASE WHEN score_edu>=0.3 AND score_edu<0.4 THEN 1 ELSE 0 END) edu_3_4,
sum(CASE WHEN score_edu>=0.4 AND score_edu<0.5 THEN 1 ELSE 0 END) edu_4_5,
sum(CASE WHEN score_edu>=0.5 AND score_edu<0.6 THEN 1 ELSE 0 END) edu_5_6,
sum(CASE WHEN score_edu>=0.6 AND score_edu<0.7 THEN 1 ELSE 0 END) edu_6_7,
sum(CASE WHEN score_edu>=0.7 AND score_edu<0.8 THEN 1 ELSE 0 END) edu_7_8,
sum(CASE WHEN score_edu>=0.8 AND score_edu<0.9 THEN 1 ELSE 0 END) edu_8_9,
sum(CASE WHEN score_edu>=0.9 AND score_edu<1.0 THEN 1 ELSE 0 END) edu_9_10,
sum(CASE WHEN score_age>=0.0 AND score_age<0.1 THEN 1 ELSE 0 END) age_0_1,
sum(CASE WHEN score_age>=0.1 AND score_age<0.2 THEN 1 ELSE 0 END) age_1_2,
sum(CASE WHEN score_age>=0.2 AND score_age<0.3 THEN 1 ELSE 0 END) age_2_3,
sum(CASE WHEN score_age>=0.3 AND score_age<0.4 THEN 1 ELSE 0 END) age_3_4,
sum(CASE WHEN score_age>=0.4 AND score_age<0.5 THEN 1 ELSE 0 END) age_4_5,
sum(CASE WHEN score_age>=0.5 AND score_age<0.6 THEN 1 ELSE 0 END) age_5_6,
sum(CASE WHEN score_age>=0.6 AND score_age<0.7 THEN 1 ELSE 0 END) age_6_7,
sum(CASE WHEN score_age>=0.7 AND score_age<0.8 THEN 1 ELSE 0 END) age_7_8,
sum(CASE WHEN score_age>=0.8 AND score_age<0.9 THEN 1 ELSE 0 END) age_8_9,
sum(CASE WHEN score_age>=0.9 AND score_age<1.0 THEN 1 ELSE 0 END) age_9_10,
sum(CASE WHEN score_net>=0.0 AND score_net<0.1 THEN 1 ELSE 0 END) net_0_1,
sum(CASE WHEN score_net>=0.1 AND score_net<0.2 THEN 1 ELSE 0 END) net_1_2,
sum(CASE WHEN score_net>=0.2 AND score_net<0.3 THEN 1 ELSE 0 END) net_2_3,
sum(CASE WHEN score_net>=0.3 AND score_net<0.4 THEN 1 ELSE 0 END) net_3_4,
sum(CASE WHEN score_net>=0.4 AND score_net<0.5 THEN 1 ELSE 0 END) net_4_5,
sum(CASE WHEN score_net>=0.5 AND score_net<0.6 THEN 1 ELSE 0 END) net_5_6,
sum(CASE WHEN score_net>=0.6 AND score_net<0.7 THEN 1 ELSE 0 END) net_6_7,
sum(CASE WHEN score_net>=0.7 AND score_net<0.8 THEN 1 ELSE 0 END) net_7_8,
sum(CASE WHEN score_net>=0.8 AND score_net<0.9 THEN 1 ELSE 0 END) net_8_9,
sum(CASE WHEN score_net>=0.9 AND score_net<1.0 THEN 1 ELSE 0 END) net_9_10
FROM idl_user_eduagenet_level_agg
WHERE ds='2017-05-06';

-- nothing to do with original intercept
-- score_edu
-- 0.00163121108|0.08979831464
-- score_age
-- 0.44739539242|0.99676504479
-- score_net
-- 0.02422610792|0.55386515371

-- trying to find intercepts
SELECT
sum(CASE WHEN score_edu>=0.0 AND score_edu<0.1561 THEN 1 ELSE 0 END)/count(1) edu_1,
sum(CASE WHEN score_edu>=0.0 AND score_edu<0.1562 THEN 1 ELSE 0 END)/count(1) edu_2,
sum(CASE WHEN score_edu>=0.0 AND score_edu<0.1563 THEN 1 ELSE 0 END)/count(1) edu_3,
sum(CASE WHEN score_edu>=0.0 AND score_edu<0.1564 THEN 1 ELSE 0 END)/count(1) edu_4,
sum(CASE WHEN score_edu>=0.0 AND score_edu<0.1565 THEN 1 ELSE 0 END)/count(1) edu_5,
sum(CASE WHEN score_edu>=0.0 AND score_edu<0.1566 THEN 1 ELSE 0 END)/count(1) edu_6,
sum(CASE WHEN score_edu>=0.0 AND score_edu<0.1567 THEN 1 ELSE 0 END)/count(1) edu_7,
sum(CASE WHEN score_edu>=0.0 AND score_edu<0.1568 THEN 1 ELSE 0 END)/count(1) edu_8,
sum(CASE WHEN score_edu>=0.0 AND score_edu<0.1569 THEN 1 ELSE 0 END)/count(1) edu_9
FROM idl_user_eduagenet_level_agg
WHERE ds='2017-05-06';

SELECT
sum(CASE WHEN score_edu<=1.0 AND score_edu>=0.404511 THEN 1 ELSE 0 END) edu_1,
sum(CASE WHEN score_edu<=1.0 AND score_edu>=0.404512 THEN 1 ELSE 0 END) edu_2,
sum(CASE WHEN score_edu<=1.0 AND score_edu>=0.404513 THEN 1 ELSE 0 END) edu_3,
sum(CASE WHEN score_edu<=1.0 AND score_edu>=0.404514 THEN 1 ELSE 0 END) edu_4,
sum(CASE WHEN score_edu<=1.0 AND score_edu>=0.404515 THEN 1 ELSE 0 END) edu_5,
sum(CASE WHEN score_edu<=1.0 AND score_edu>=0.404516 THEN 1 ELSE 0 END) edu_6,
sum(CASE WHEN score_edu<=1.0 AND score_edu>=0.404517 THEN 1 ELSE 0 END) edu_7,
sum(CASE WHEN score_edu<=1.0 AND score_edu>=0.404518 THEN 1 ELSE 0 END) edu_8,
sum(CASE WHEN score_edu<=1.0 AND score_edu>=0.404519 THEN 1 ELSE 0 END) edu_9
FROM idl_user_eduagenet_level_agg
WHERE ds='2017-05-06';

SELECT
sum(CASE WHEN score_age<=1.0 AND score_age>=0.5000461 THEN 1 ELSE 0 END) age_1,
sum(CASE WHEN score_age<=1.0 AND score_age>=0.5000462 THEN 1 ELSE 0 END) age_2,
sum(CASE WHEN score_age<=1.0 AND score_age>=0.5000463 THEN 1 ELSE 0 END) age_3,
sum(CASE WHEN score_age<=1.0 AND score_age>=0.5000464 THEN 1 ELSE 0 END) age_4,
sum(CASE WHEN score_age<=1.0 AND score_age>=0.5000465 THEN 1 ELSE 0 END) age_5,
sum(CASE WHEN score_age<=1.0 AND score_age>=0.5000466 THEN 1 ELSE 0 END) age_6,
sum(CASE WHEN score_age<=1.0 AND score_age>=0.5000467 THEN 1 ELSE 0 END) age_7,
sum(CASE WHEN score_age<=1.0 AND score_age>=0.5000488 THEN 1 ELSE 0 END) age_8
FROM idl_user_eduagenet_level_agg
WHERE ds='2017-05-06';

SELECT
sum(CASE WHEN score_net<=1.0 AND score_net>=0.49989791 THEN 1 ELSE 0 END) net_1,
sum(CASE WHEN score_net<=1.0 AND score_net>=0.49989792 THEN 1 ELSE 0 END) net_2,
sum(CASE WHEN score_net<=1.0 AND score_net>=0.49989793 THEN 1 ELSE 0 END) net_3,
sum(CASE WHEN score_net<=1.0 AND score_net>=0.49989794 THEN 1 ELSE 0 END) net_4,
sum(CASE WHEN score_net<=1.0 AND score_net>=0.49989795 THEN 1 ELSE 0 END) net_5,
sum(CASE WHEN score_net<=1.0 AND score_net>=0.49989796 THEN 1 ELSE 0 END) net_6,
sum(CASE WHEN score_net<=1.0 AND score_net>=0.49989797 THEN 1 ELSE 0 END) net_7,
sum(CASE WHEN score_net<=1.0 AND score_net>=0.49989798 THEN 1 ELSE 0 END) net_8
FROM idl_user_eduagenet_level_agg
WHERE ds='2017-05-06';

-- test
-- edu:0.15690|0.404511
-- age:0.5000461
-- net:0.30|0.49989798
SELECT
sum(CASE WHEN score_edu>=0.0 AND score_edu<0.1569 THEN 1 ELSE 0 END)/count(1) edu_0,
sum(CASE WHEN score_edu>=0.1569 AND score_edu<0.404511 THEN 1 ELSE 0 END)/count(1) edu_1,
sum(CASE WHEN score_edu>=0.404511 AND score_edu<=1.0 THEN 1 ELSE 0 END)/count(1) edu_2,
sum(CASE WHEN score_age>=0.0 AND score_age<0.5000461 THEN 1 ELSE 0 END)/count(1) age_0,
sum(CASE WHEN score_age>=0.5000461 AND score_age<=1.0 THEN 1 ELSE 0 END)/count(1) age_1,
sum(CASE WHEN score_net>=0.0 AND score_net<0.30 THEN 1 ELSE 0 END)/count(1) net_0,
sum(CASE WHEN score_net>=0.30 AND score_net<0.49989798 THEN 1 ELSE 0 END)/count(1) net_1,
sum(CASE WHEN score_net>=0.49989798 AND score_net<=1.0  THEN 1 ELSE 0 END)/count(1) net_2
FROM idl_user_eduagenet_level_agg
WHERE ds='2017-05-06';

