/*
R.001914

----------

Name: Invalid EMAIL format
Created by: Heather Braum

----------

Group: Patrons
     Fix Patrons

Created on: 2013-06-24 09:51:23
Modified on: 2013-06-24 09:51:23
Date last run: 2018-11-15 13:14:25

----------

Public: 0
Expiry: 300

----------

From Koha listserv/wiki

----------
*/

SELECT surname AS Surname, firstname AS "First Name", cardnumber AS
"Card Number", email AS Email
FROM borrowers
WHERE email NOT LIKE '%_@__%.__%' AND branchcode=<<choose branch|branches>>
ORDER BY email DESC



