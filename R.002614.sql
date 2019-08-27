/*
R.002614

----------

Name: Missing holds in transit from courier accident
Created by: Heather Braum

----------

Group: -
     -

Created on: 2015-10-09 13:59:17
Modified on: 2015-10-09 14:51:10
Date last run: 2018-09-18 12:02:25

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT * FROM reserves where itemnumber iN (SELECT itemnumber from items where itemlost='4' and damaged='2')



