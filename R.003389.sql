/*
R.003389

----------

Name: GHW - Open refine ADMINREPORT
Created by: George Williams

----------

Group: -
     -

Created on: 2020-11-30 16:48:41
Modified on: 2025-08-18 13:31:49
Date last run: 2025-08-18 13:32:04

----------

Public: 0
Expiry: 300

----------

 
Outputs borrower address in a way that can be easily imported back into Koha via the patron import tool
Shows current borrowers
at the library you specify
designed to be flexible

Notes:

Notes go here.

Click here to run in a new window
hidden flexible openrefine


----------
*/



SELECT
  UPPER(borrowers.cardnumber) AS cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.country,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateenrolled
FROM
  borrowers
WHERE
  borrowers.branchcode NOT LIKE "HIGH_CC" AND
  /* borrowers.branchcode NOT LIKE "PH%" AND */
  borrowers.branchcode LIKE &lt;&gt; AND
  borrowers.categorycode &lt;&gt; "STAFF" AND
  borrowers.cardnumber NOT LIKE "0%" AND
  borrowers.cardnumber IS NOT NULL AND
  borrowers.cardnumber NOT LIKE "" AND
  borrowers.address LIKE Concat(&lt;&gt; ,"%") AND
  borrowers.city LIKE Concat(&lt;&gt;, "%") AND
  borrowers.state LIKE Concat(&lt;&gt;, "%")

























