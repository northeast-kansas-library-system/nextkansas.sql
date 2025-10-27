/*
R.002882

----------

Name: GHW - Patrons with multiple holds on 1 biblio
Created by: George Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-01-10 11:28:21
Modified on: 2024-01-17 11:46:26
Date last run: 2025-10-27 09:30:51

----------

Public: 0
Expiry: 0

----------

 
Generates a list of all items where 1 patron has more than 1 hold on 1 bibliographic record
Shows current multiple holds
at all NExpress libraries
grouped by biblionumber, patron barcode, and borrowernumber
sorted by biblionumber, patron barcode, and borrowernumber
contains links to the request record and the patron record

Notes:

Click here to run in a new window


----------
*/



SELECT
  Concat('',
  reserves.biblionumber, '') AS LINK_TO_REQUESTS,
  reserves.biblionumber AS BIBLIO,
  borrowers.cardnumber AS CARD_NUMBER,
  Count(reserves.borrowernumber) AS Count_borrowernumber,
  Concat('', borrowers.borrowernumber, '') AS LINK_TO_PATRON
FROM
  reserves
  JOIN borrowers ON reserves.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.categorycode &lt;&gt; 'BOOKCLUB'  AND
  reserves.found IS NULL   
GROUP BY
  reserves.biblionumber,
  borrowers.cardnumber,
  borrowers.borrowernumber
HAVING
  Count(reserves.borrowernumber) &gt; 1

























