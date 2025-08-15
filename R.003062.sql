/*
R.003062

----------

Name: GHW - Bounced text message helper
Created by: George Williams

----------

Group: -
     -

Created on: 2018-03-12 11:28:45
Modified on: 2024-04-25 08:34:43
Date last run: 2024-07-12 09:07:37

----------

Public: 0
Expiry: 300

----------

 
Generates a list of patrons based on their SMS text messaging e-mail address and produces a "Bounced Text" message that can be quickly cut and pasted into a message on the patron's account.
Shows all borrowers that are using the specified SMS text e-mail address that has bounced in the last 60 days
Shows borrowers at all NExpress branches with that SMS text e-mail address
grouped by barcode number
includes links to the patron record

Notes:

If more than one patron is using the text messaging number you enter on their account, you will receive one result in this report for each patron with that number.

For bounced e-mails, use report 2910.

Click here to run in a new window


----------
*/



SELECT
  borrowers.smsalertnumber AS TEXT_NUMBER,
  borrowers.cardnumber,
  Concat("&lt;br /&gt;BOUNCED SMS TEXT MESSAGE&lt;br /&gt;An SMS text message sent to this patron's phone number at &lt;strong&gt;(",
  borrowers.smsalertnumber,
  ")&lt;/strong&gt; bounced.&lt;br /&gt;Please confirm the patron's contact information the next time they use their account.&lt;br /&gt;", CurDate()) AS MESSAGE,
  Concat('',
  borrowers.borrowernumber, '') AS 'LINK_TO_PATRON'
FROM
  borrowers
  JOIN message_queue ON message_queue.borrowernumber = borrowers.borrowernumber
WHERE
  message_queue.to_address LIKE CONCAT("%", &lt;&gt;,"%")
GROUP BY
  borrowers.borrowernumber

























