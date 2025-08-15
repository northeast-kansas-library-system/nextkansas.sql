/*
R.002796

----------

Name: GHW - Duplicate holds on a bibliographic record
Created by: George Williams

----------

Group: Holds-Reserves
     Duplicate request problems

Created on: 2016-10-10 08:59:30
Modified on: 2024-01-17 11:36:18
Date last run: 2023-04-26 11:21:06

----------

Public: 0
Expiry: 0

----------

 
Searches for duplicate patron holds on a bibliographic record
Searches for current requests
on a specified biblionumber (text input accepts wildcards)
grouped by biblionumber and borrowernumber
sorted by biblionumber and borrowernumber

Notes:
Helpful for identifying duplicate requests caused by merging records.
Click here to run this report in a new window.



----------
*/



SELECT
  reserves.biblionumber,
  reserves.borrowernumber,
  borrowers.surname,
  COUNT(reserves.borrowernumber) AS COUNT_OF_REQUESTS
FROM reserves JOIN borrowers ON reserves.borrowernumber = borrowers.borrowernumber
WHERE (reserves.biblionumber LIKE &lt;&gt;)
GROUP BY reserves.biblionumber, reserves.borrowernumber
HAVING COUNT_OF_REQUESTS &gt; 1

























