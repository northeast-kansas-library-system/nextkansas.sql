/*
R.003145

----------

Name: GHW - ADMINREPORT - Adult patrons with guarantors
Created by: George Williams

----------

Group: -
     -

Created on: 2018-12-17 15:12:26
Modified on: 2024-01-17 11:55:50
Date last run: 2020-07-27 16:21:33

----------

Public: 0
Expiry: 300

----------

 
Adult patrons with lingering guarantor problems
Shows patrons who still have guarantor information connected to their accounts even though they are now adults
Shows patrons at all libraries

Notes:

Click here to run in a new window
Click here to download as a csv file


----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.contactname,
  borrowers.contactfirstname,
  borrowers.contacttitle,
  borrowers.relationship,
  borrower_relationships.guarantor_id
FROM
  borrowers LEFT JOIN
  borrower_relationships ON borrower_relationships.guarantee_id =
      borrowers.borrowernumber
WHERE
  (borrowers.dateofbirth &lt;= CurDate() - INTERVAL 18 YEAR OR
      borrowers.dateofbirth IS NULL) AND
  borrower_relationships.guarantor_id IS NOT NULL
GROUP BY
  borrower_relationships.guarantor_id,
  borrowers.borrowernumber

























