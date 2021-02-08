/*
R.002165

----------

Name: Total Print Added in a Year (single branch)
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Yearly

Created on: 2014-01-16 13:58:25
Modified on: 2014-01-16 14:02:21
Date last run: 2021-01-19 09:53:10

----------

Public: 0
Expiry: 0

----------

Groups Book, Localholdbook, walkinbook, newbook, and reference item types together

----------
*/

SELECT homebranch, count(itemnumber) as addeditems from items WHERE homebranch=<<branch|branches>> AND year(dateaccessioned) = <<enter year>> AND itype IN ('BOOK','LOCALHOLD2','WALKIN2','REFERENCE','NEWBOOK') GROUP BY homebranch ORDER BY homebranch



