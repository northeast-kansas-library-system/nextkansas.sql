/*
R.003135

----------

Name: GHW Bad guarantor information - ADMINREPORT
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2018-11-05 14:12:57
Modified on: 2019-01-29 09:08:18
Date last run: 2020-07-27 13:36:55

----------

Public: 0
Expiry: 300

----------

Remove content from columns E-H then re-import/overwrite.

----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.contactname,
  borrowers.contactfirstname,
  borrowers.contacttitle,
  borrowers.guarantorid
FROM
  borrowers
WHERE
  (borrowers.dateofbirth <= CurDate() - INTERVAL 18 YEAR or borrowers.dateofbirth IS NULL) AND
  (borrowers.guarantorid is not null OR
  borrowers.guarantorid <> "" OR
  borrowers.contactname <> "" OR
  borrowers.contactfirstname <> "" OR
  borrowers.contacttitle <> "")
GROUP BY
  borrowers.borrowernumber

























