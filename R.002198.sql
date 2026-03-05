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
Date last run: 2026-01-08 17:48:07

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT count(&ast;) FROM borrowers WHERE branchcode=&lt;&gt; AND year(dateenrolled)=&lt;&gt; AND month(dateenrolled)=&lt;&gt;

























