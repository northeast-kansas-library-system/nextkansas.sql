/*
R.001917

----------

Name: Single Items on Titles with Holds
Created by: Heather Braum

----------

Group: Administrative Reports
     Holds-admin

Created on: 2013-06-24 14:41:11
Modified on: 2013-06-24 14:41:11
Date last run: -

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT b.title, b.biblionumber, count(r.reservedate) AS holds 
FROM reserves r 
LEFT JOIN biblio b USING (biblionumber) 
WHERE r.biblionumber IN 
     (SELECT b.biblionumber 
      FROM biblio b 
      LEFT JOIN items i USING (biblionumber) 
      GROUP BY b.biblionumber 
      HAVING count(i.itemnumber) = 1) 
GROUP BY b.biblionumber




