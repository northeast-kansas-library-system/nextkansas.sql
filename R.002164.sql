/*
R.002164

----------

Name: Total Print Added in a Year (all branches)
Created by: Heather Braum

----------

Group: Administrative Reports
     Daily, Monthly, Yearly Stats-admin

Created on: 2014-01-16 13:56:50
Modified on: 2014-01-16 14:00:55
Date last run: -

----------

Public: 0
Expiry: 0

----------

Groups Book, Localholdbook, walkinbook, newbook, and reference item types together

----------
*/

SELECT homebranch, count(itemnumber) as addeditems from items WHERE year(dateaccessioned) = <<enter year>> AND itype IN ('BOOK','LOCALHOLD2','WALKIN2','REFERENCE','NEWBOOK') GROUP BY homebranch ORDER BY homebranch



