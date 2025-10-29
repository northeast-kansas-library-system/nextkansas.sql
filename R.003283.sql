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

<div class="reportinfo noprint"> 
<p>Find a patron's card number based on a portion of their SMS text messaging number</p>
<ul><li>Shows all patrons that currently have that portion of an SMS text number</li>
<li>at all libraries</li>
<li>grouped by borrowernumber</li>
<li>grouped by text messaging phone number</li>
<li>links to the patron's account</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Text message numbers are ten digits long and  only contain numerals - no spaces, letters, or punctuation.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3283&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

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

























