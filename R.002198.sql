/*
R.002198

----------

Name: New Patrons Added in a Month
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Monthly

Created on: 2014-02-28 15:23:13
Modified on: 2014-02-28 15:23:13
Date last run: 2021-09-13 16:33:37

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT count(*) FROM borrowers WHERE branchcode=<<branch|branches>> AND year(dateenrolled)=<<enter four-digit year>> AND month(dateenrolled)=<<enter two-digit month>>

























