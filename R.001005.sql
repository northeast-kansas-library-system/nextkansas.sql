/*
R.001005

----------

Name: Trapped Holds at wrong pick up branch
Created by: -

----------

Group: Administrative Reports
     Holds-admin

Created on: 2010-12-13 11:13:03
Modified on: 2013-06-19 12:44:21
Date last run: 2020-07-21 16:31:28

----------

Public: 0
Expiry: 0

----------

Admin report - used for finding possible mis-routed holds.

----------
*/



select biblio.title, reserves.branchcode as 'pickup branch', borrowers.branchcode as 'borrower branch', borrowers.surname, borrowers.firstname from reserves LEFT JOIN biblio USING (biblionumber) LEFT JOIN borrowers USING (borrowernumber) WHERE reserves.priority = 0 and found = 't' and reserves.branchcode != borrowers.branchcode order by reserves.branchcode, borrowers.branchcode

























