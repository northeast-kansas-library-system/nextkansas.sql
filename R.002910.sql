/*
R.002910

----------

Name: GHW - Bounced e-mail helper
Created by: George Williams

----------

Group: Borrowers
     -

Created on: 2017-02-20 18:56:41
Modified on: 2024-04-18 08:30:44
Date last run: 2024-07-19 09:06:59

----------

Public: 0
Expiry: 0

----------

 
Generates a list of patrons based on their e-mail address and produces a "Bounced Email" message that can be quickly cut and pasted into a message on the patron's account.
Shows all borrowers that are using the specified e-mail address
Shows borrowers at all NExpress branches with that e-mail address
grouped by barcode number
includes links to the patron record

Notes:

If more than one patron is using the e-mail address you enter on their account, you will receive one result in this report for each patron with that e-mail address.

For bounced text messages, use report 3062.

Click here to run in a new window


----------
*/



SELECT
  borrowers.email,
  borrowers.cardnumber,
  Concat("&lt;br /&gt;BOUNCED EMAIL&lt;br /&gt;An e-mail sent to this patron's e-mail address &lt;strong&gt;(",borrowers.email,")&lt;/strong&gt; bounced.&lt;br /&gt;Please confirm the patron's contact information the next time they use their account.&lt;br /&gt;", CurDate()) AS MESSAGE,
  Concat('', borrowers.borrowernumber,'') AS 'LINK_TO_PATRON'
FROM
  borrowers
WHERE
  borrowers.email LIKE CONCAT( '%',&lt;&gt;, '%')
GROUP BY borrowers.cardnumber

























