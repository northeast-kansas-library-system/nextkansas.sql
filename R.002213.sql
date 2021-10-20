/*
R.002213

----------

Name: Accounts with Staff-Level Permissions
Created by: Heather Braum

----------

Group: Administrative Reports
     System-admin

Created on: 2014-03-14 11:41:08
Modified on: 2018-06-21 14:19:30
Date last run: 2019-08-19 15:28:08

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT CONCAT('<a href=\"/cgi-bin/koha/members/member-flags.pl?member=',borrowernumber,'\" target="_blank">',borrowernumber,'</a>') AS "Edit Permissions",
  firstname, surname,
  userid, flags,
  categorycode,
  branchcode
FROM borrowers
WHERE flags NOT IN  ('0')
ORDER BY flags

























