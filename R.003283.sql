/*
R.003283

----------

Name: GHW - Search for borrower by SMS text message number
Created by: George H Williams

----------

Group: Patrons
     -

Created on: 2019-11-27 10:45:22
Modified on: 2020-03-27 09:48:06
Date last run: 2020-07-09 15:53:17

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
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
  Concat('<a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', borrowers.borrowernumber, '" target="_blank">Go to patron account</a>') AS LINK,
  borrowers.cardnumber,
  borrowers.smsalertnumber
FROM
  borrowers
WHERE
  borrowers.smsalertnumber LIKE CONCAT("%", REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(<<Enter part of a text messaging number>>, ' ', ''), '-', ''), '(', ''), ')', ''), '.', ''), "%")
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.smsalertnumber



