/*
R.002434

----------

Name: 9.1b books added during calendar year (part 2)
Created by: Heather Braum

----------

Group: Administrative Reports
     -

Created on: 2015-01-08 16:57:24
Modified on: 2017-02-06 10:06:32
Date last run: -

----------

Public: 0
Expiry: 0

----------

This report gives total number of books added during prev year that were then deleted. Need to run part 1 report to get number of items added in prev year. Ready for 2016

----------
*/

SELECT homebranch, count(*) FROM deleteditems WHERE year(dateaccessioned)='2015' AND ((itype IN ('book','localhold2','newbook','walkin2')) OR (itype='localhold' and ccode IN ('easy','fiction','nonfiction','profcoll')) OR (itype='reference' and ccode NOT IN ('bookoncd','bookonmp','computer','GADGET','GAMECUBE','magazine','MAP','SOFTWARE','vhs','dvd','misc','blu-ray')) OR (itype='walkin' and ccode IN ('biography','easy','holiday','kansas','genealogy','nonfiction','profcoll','walkin'))) GROUP BY homebranch LIMIT 100


