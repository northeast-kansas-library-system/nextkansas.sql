/*
R.002629

----------

Name: Sort1 Query
Created by: Heather Braum

----------

Group: -
     -

Created on: 2015-11-12 12:17:57
Modified on: 2015-11-12 12:18:53
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT borrowernumber, branchcode, sort1 FROM borrowers where sort1 <> '' AND sort1 IS NOT NULL



