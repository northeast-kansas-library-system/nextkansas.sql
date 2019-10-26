/*
R.002440

----------

Name: 11.2 Circulation of Children's + YA Materials
Created by: Heather Braum

----------

Group: Administrative Reports
     -

Created on: 2015-01-08 21:26:05
Modified on: 2017-02-06 10:05:02
Date last run: -

----------

Public: 0
Expiry: 0

----------

Ready for 2016

----------
*/

SELECT statistics.branch, Count(*) AS count FROM borrowers LEFT JOIN deletedborrowers USING(borrowernumber) LEFT JOIN statistics USING(borrowernumber) LEFT JOIN items USING(itemnumber) LEFT JOIN deleteditems USING(itemnumber) WHERE statistics.type IN ('issue','renew') AND year(statistics.datetime) = '2015' AND (deleteditems.location IN ('CHILDRENS','CART','YOUNGADULT') OR items.location IN ('CHILDRENS','CART','YOUNGADULT'))
GROUP BY statistics.branch 


