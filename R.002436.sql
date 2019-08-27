/*
R.002436

----------

Name: 9.2 – Total Audio – Physical Units (CDs and Playaways)
Created by: Heather Braum

----------

Group: Administrative Reports
     -

Created on: 2015-01-08 17:03:27
Modified on: 2017-02-06 10:07:14
Date last run: -

----------

Public: 0
Expiry: 0

----------

ready for 2016. 

----------
*/

SELECT homebranch, count(*) FROM items WHERE year(dateaccessioned) < '2016' AND 
(itype IN ('audiobook','newaudio','flplayaway')) OR (itype = 'book' and ccode IN ('bookoncd','bookoncass')) OR (itype IN ('localhold','localhold2','kits','newbook','reference','walkin','xxx') and ccode IN ('bookoncd','bookoncass','bookonmp')) GROUP BY homebranch LIMIT 100



