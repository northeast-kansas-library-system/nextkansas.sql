/*
R.003186

----------

Name: GHW - generates 1 patron name based on the patron's ID number
Created by: George Williams

----------

Group: -
     -

Created on: 2019-03-20 17:44:30
Modified on: 2024-01-17 11:54:54
Date last run: 2024-01-24 11:15:48

----------

Public: 0
Expiry: 1

----------

 
Returns 1 patron name based based on the specified borrowernumber
Shows a current patron name
based on the borrowernumber you enter
grouped and sorted by the borrower's name

Notes:

The purpose of this report is to provide JSON output in order to put the patron's name on the "Hold filled" checkin message pop-up.



----------
*/



SELECT
  Group_Concat(borrowers.surname, ", ", borrowers.firstname, " - ") AS BORROWER_NAME
FROM
  borrowers
WHERE
  borrowers.borrowernumber = &lt;&gt;

























