/*
R.002166

----------

Name: Total Print Deleted in a Year (single branch)
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Yearly

Created on: 2014-01-16 13:59:56
Modified on: 2014-01-16 14:02:48
Date last run: 2020-10-15 14:48:52

----------

Public: 0
Expiry: 0

----------

Groups Book, Localholdbook, walkinbook, newbook, and reference item types together

----------
*/



SELECT homebranch, count(itemnumber) as deletedtotal from deleteditems WHERE homebranch=<<branch|branches>> AND year(timestamp) = <<enter year>> AND itype IN ('BOOK','LOCALHOLD2','WALKIN2','REFERENCE','NEWBOOK') GROUP BY homebranch

























