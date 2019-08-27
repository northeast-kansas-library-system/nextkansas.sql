/*
R.003002

----------

Name: stats
Created by: TONGANOXIE TECH

----------

Group: -
     -

Created on: 2017-10-03 13:51:33
Modified on: 2017-10-03 13:51:33
Date last run: 2018-05-04 17:32:42

----------

Public: 1
Expiry: 300

----------



----------
*/

SELECT sum(borrowers.borrowernumber), borrowers.borrowernumber FROM borrowers   WHERE borrowers.branchcode='TONGANOXIE'  AND borrowers.zipcode='66002' GROUP BY borrowers.borrowernumber ORDER BY borrowers.borrowernumber asc



