/*
R.002431

----------

Name: 9.1a books owned as of beginning of prev  year (part 1)
Created by: Heather Braum

----------

Group: Administrative Reports
     -

Created on: 2015-01-08 16:37:35
Modified on: 2020-01-01 14:17:04
Date last run: 2023-03-13 16:47:00

----------

Public: 0
Expiry: 0

----------

This report gives total number of books owned as of January 1, [previous year]. Need to run part 2 report to get items deleted in [previous year] that were added before [previous year]. ready for 2016. 

----------
*/



SELECT homebranch, count(*) FROM items WHERE dateaccessioned < '2019-01-01' AND ((itype IN ('book','localhold2','newbook','walkin2')) OR (itype='localhold' and ccode IN ('easy','fiction','nonfiction','profcoll')) OR (itype='reference' and ccode NOT IN ('bookoncd','bookonmp','computer','GADGET','GAMECUBE','magazine','MAP','SOFTWARE','vhs','dvd','misc','blu-ray')) OR (itype='walkin' and ccode IN ('biography','easy','holiday','kansas','genealogy','nonfiction','profcoll','walkin'))) GROUP BY homebranch LIMIT 100

























