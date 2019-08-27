/*
R.002058

----------

Name: Count of holds not filled in a month of all branches
Created by: Heather Braum

----------

Group: Administrative Reports
     Holds-admin

Created on: 2013-10-22 14:43:05
Modified on: 2013-10-22 14:46:07
Date last run: 2018-03-27 14:08:39

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT branchcode, count(reserve_id) FROM reserves WHERE priority='0' AND MONTH(reservedate)=<<enter month>> AND YEAR(reservedate)=<<enter year>>GROUP BY branchcode LIMIT 100



