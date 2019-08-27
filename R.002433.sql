/*
R.002433

----------

Name: 9.1b books added during calendar year (part 1)
Created by: Heather Braum

----------

Group: Administrative Reports
     -

Created on: 2015-01-08 16:47:44
Modified on: 2017-02-06 10:06:09
Date last run: 2018-01-12 10:43:46

----------

Public: 0
Expiry: 0

----------

This report gives total number of books added during prev year. Need to run part 2 report to get number of items deleted in prev year that were added in prev year.  ready for 2016

----------
*/

SELECT homebranch, count(*) FROM items WHERE year(dateaccessioned)='2016' AND ((itype IN ('book','localhold2','newbook','walkin2')) OR (itype='localhold' and ccode IN ('easy','fiction','nonfiction','profcoll')) OR (itype='reference' and ccode NOT IN ('bookoncd','bookonmp','computer','GADGET','GAMECUBE','magazine','MAP','SOFTWARE','vhs','dvd','misc','blu-ray')) OR (itype='walkin' and ccode IN ('biography','easy','holiday','kansas','genealogy','nonfiction','profcoll','walkin'))) GROUP BY homebranch LIMIT 100



