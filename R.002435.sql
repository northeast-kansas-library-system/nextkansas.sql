/*
R.002435

----------

Name: 9.1c – Books withdrawn during calendar year
Created by: Heather Braum

----------

Group: Administrative Reports
     -

Created on: 2015-01-08 16:59:15
Modified on: 2017-02-06 10:06:54
Date last run: 2021-01-13 10:40:00

----------

Public: 0
Expiry: 0

----------

This report gives the total number of items deleted in prev year. ready for 2016.

----------
*/

SELECT homebranch, count(*) FROM deleteditems WHERE year(timestamp)='2015' AND ((itype IN ('book','localhold2','newbook','walkin2')) OR (itype='localhold' and ccode IN ('easy','fiction','nonfiction','profcoll')) OR (itype='reference' and ccode NOT IN ('bookoncd','bookonmp','computer','GADGET','GAMECUBE','magazine','MAP','SOFTWARE','vhs','dvd','misc','blu-ray')) OR (itype='walkin' and ccode IN ('biography','easy','holiday','kansas','genealogy','nonfiction','profcoll','walkin'))) GROUP BY homebranch LIMIT 100



