/*
R.001915

----------

Name: Invalid EMAIL format
Created by: Heather Braum

----------

Group: Patrons
     Fix Patrons

Created on: 2013-06-24 09:51:23
Modified on: 2013-06-24 14:48:08
Date last run: 2020-02-25 20:55:44

----------

Public: 0
Expiry: 0

----------

From Koha listserv/wiki

----------
*/

SELECT surname AS Surname, firstname AS "First Name", cardnumber AS
"Card Number", email AS Email
FROM borrowers
WHERE branchcode=<<choose branch|branches>> AND borrowernumber NOT IN (SELECT borrowernumber FROM borrowers WHERE ' ' IN (email)) AND email NOT LIKE '%_@__%.__%' 
ORDER BY email DESC LIMIT 10000



