/*
R.002163

----------

Name: Total Print Deleted in a Year (all branches)
Created by: Heather Braum

----------

Group: Administrative Reports
     Daily, Monthly, Yearly Stats-admin

Created on: 2014-01-16 13:55:29
Modified on: 2014-01-16 13:55:29
Date last run: -

----------

Public: 0
Expiry: 300

----------

Groups Book, Localholdbook, walkinbook, newbook, and reference item types together

----------
*/

SELECT homebranch, count(itemnumber) as deletedtotal from deleteditems WHERE year(timestamp) = <<enter year>> AND itype IN ('BOOK','LOCALHOLD2','WALKIN2','REFERENCE','NEWBOOK') GROUP BY homebranch ORDER BY homebranch



