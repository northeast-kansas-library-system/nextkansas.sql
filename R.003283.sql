/*
R.003283

----------

Name: GHW - Search for borrower by SMS text message number
Created by: George Williams

----------

Group: Borrowers
     -

Created on: 2019-11-27 10:45:22
Modified on: 2024-01-17 12:05:57
Date last run: 2022-10-06 14:38:32

----------

Public: 0
Expiry: 300

----------

 
Find a patron's card number based on a portion of their SMS text messaging number
Shows all patrons that currently have that portion of an SMS text number
at all libraries
grouped by borrowernumber
grouped by text messaging phone number
links to the patron's account

Notes:

Text message numbers are ten digits long and  only contain numerals - no spaces, letters, or punctuation.

Click here to run in a new window


----------
*/



SELECT
  Concat('Go to patron account') AS LINK,
  borrowers.cardnumber,
  borrowers.smsalertnumber
FROM
  borrowers
WHERE
  borrowers.smsalertnumber LIKE CONCAT("%", REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(&lt;&gt;, ' ', ''), '-', ''), '(', ''), ')', ''), '.', ''), "%")
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.smsalertnumber

























