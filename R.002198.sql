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
Date last run: 2026-08-05 18:30:44

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT count(*) FROM borrowers WHERE branchcode=<<branch|branches>> AND year(dateenrolled)=<<enter four-digit year>> AND month(dateenrolled)=<<enter two-digit month>>

























