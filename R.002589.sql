/*
R.002589

----------

Name: Total Patrons for a month for Overbrook
Created by: Heather Braum

----------

Group: Library-Specific
     Overbrook

Created on: 2015-08-28 05:48:05
Modified on: 2016-07-01 12:21:22
Date last run: -

----------

Public: 0
Expiry: 0

----------

For whenever Overbrook needs their stats earlier than normal. 

----------
*/

SELECT count(*) as "total patrons" FROM borrowers WHERE branchcode='OVERBROOK' AND dateenrolled < <<Choose first of the next month, to count previous month (example 7/1/16 for June numbers)|date>>



