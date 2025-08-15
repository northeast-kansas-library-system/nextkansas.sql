/*
R.002879

----------

Name: GHW - Tonganoxie 200th patron report
Created by: George Williams

----------

Group:  TONGANOXIE
     -

Created on: 2017-01-06 12:02:25
Modified on: 2024-01-17 11:46:28
Date last run: 2024-09-19 14:26:22

----------

Public: 0
Expiry: 0

----------

 
Shows an index of patrons with a TONGANOXIE home library during the 2017 calendar year
Shows patrons added during 2017
With a Tonganoxie home branch
grouped by borrowers.cardnumber, borrowers.dateenrolled, borrowers.borrowernumber
sorted by patron index number

Notes:

Click here to run in a new window


----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.dateenrolled,
  @curRow := @curRow + 1 AS PATRON_NUMBER
FROM
  borrowers CROSS JOIN
  (SELECT
    @curRow := 0) r
WHERE
  borrowers.branchcode = 'Tonganoxie' AND
  Year(borrowers.dateenrolled) = 2017
GROUP BY
  borrowers.cardnumber, borrowers.dateenrolled, borrowers.borrowernumber
ORDER BY
  PATRON_NUMBER DESC

























