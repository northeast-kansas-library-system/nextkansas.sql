/*
R.002910

----------

Name: GHW - Bounced e-mail helper
Created by: George H Williams

----------

Group: Borrowers
     -

Created on: 2017-02-20 18:56:41
Modified on: 2018-04-16 11:08:08
Date last run: 2023-05-03 10:40:28

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Generates a list of patrons based on their e-mail address and produces a "Bounced Email" message that can be quickly cut and pasted into a message on the patron's account.</p>
<ul><li>Shows all borrowers that are using the specified e-mail address</li>
<li>Shows borrowers at all NExpress branches with that e-mail address</li>
<li>grouped by barcode number</li>
<li>includes links to the patron record</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>If more than one patron is using the e-mail address you enter on their account, you will receive one result in this report for each patron with that e-mail address.</p>
<p></p>
<p>For bounced text messages, use report 3062.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2910&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  borrowers.email,
  borrowers.cardnumber,
  Concat("BOUNCED EMAIL<br />An e-mail sent to this patron's e-mail address <strong>(",borrowers.email,")</strong> bounced.<br />Please confirm the patron's contact information the next time they use their account.<br />", CurDate()) AS MESSAGE,
  Concat('<a href=\"/cgi-bin/koha/circ/circulation.pl?borrowernumber=', borrowers.borrowernumber, '\" target="_blank">', borrowers.borrowernumber,'</a>') AS 'LINK_TO_PATRON'
FROM
  borrowers
WHERE
  borrowers.email LIKE CONCAT( '%',<<Enter patron's e-mail address>>, '%')
GROUP BY borrowers.cardnumber

























