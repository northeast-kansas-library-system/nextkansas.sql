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
Date last run: 2025-10-02 12:16:10

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT count(*) FROM borrowers WHERE branchcode=<> AND year(dateenrolled)=<> AND month(dateenrolled)=<>

























