/*
R.003062

----------

Name: GHW - Bounced text message helper
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-03-12 11:28:45
Modified on: 2018-04-16 11:14:02
Date last run: 2022-10-03 09:08:23

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a list of patrons based on their SMS text messaging e-mail address and produces a "Bounced Text" message that can be quickly cut and pasted into a message on the patron's account.</p>
<ul><li>Shows all borrowers that are using the specified SMS text e-mail address that has bounced in the last 60 days</li>
<li>Shows borrowers at all NExpress branches with that SMS text e-mail address</li>
<li>grouped by barcode number</li>
<li>includes links to the patron record</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>If more than one patron is using the text messaging number you enter on their account, you will receive one result in this report for each patron with that number.</p>
<p></p>
<p>For bounced e-mails, use report 2910.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3062&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  borrowers.smsalertnumber AS TEXT_NUMBER,
  borrowers.cardnumber,
  Concat("BOUNCED EMAIL<br />An SMS text message sent to this patron's phone number at <strong>(",
  borrowers.smsalertnumber,
  ")</strong> bounced.<br />Please confirm the patron's contact information the next time they use their account.<br />", CurDate()) AS MESSAGE,
  Concat('<a href=\"/cgi-bin/koha/circ/circulation.pl?borrowernumber=', borrowers.borrowernumber, '\" target="_blank">',
  borrowers.borrowernumber, '</a>') AS 'LINK_TO_PATRON'
FROM
  borrowers
  JOIN message_queue ON message_queue.borrowernumber = borrowers.borrowernumber
WHERE
  message_queue.to_address LIKE CONCAT("%", <<Enter the e-mail address from the bounced text message error report>>,"%")
GROUP BY
  borrowers.borrowernumber

























