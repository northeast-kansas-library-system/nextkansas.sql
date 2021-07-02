/*
R.003009

----------

Name: GHW - Accountlines by item barcode number
Created by: George H Williams

----------

Group: Fines/Fees
     -

Created on: 2017-10-23 09:30:01
Modified on: 2021-02-08 16:44:08
Date last run: 2021-07-02 14:35:35

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Shows accountline information for a particular item if the item's barcode number has been stored in the accountlines description or accountlines note fields</p>
<ul><li>Shows all accountlines related to the item barcode number specified</li>
<li>Shows accountlines related to that item regardless as to which item owns the item or is owed the fee</li>
<li>grouped and sorted by patron barcode number and accountline id</li>
<li>links to the patron's fine history</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p style="text-decoration: underline;">This report can only show the fee history on an item if the barcode number of the item was recorded in the description or note fields of the fee record.  Currently Koha no longer stores this information automatically in the description or note fields.</p>
<p>This report can only show the fines history on an item if the fee is unpaid or was paid less than 25 months ago.</p>
<p>In some version of Koha, the item barcode number was not always stored in the description field.  If the item's barcode number was not stored in the description or note fields, this report cannot recover the data about the fee history.</p>
<p>This report will show any entries in the patron's fee history - fees, credits, notes, writeoffs, etc.  The only requirement is that the fee description or note contains the item barcode number you are searching for.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3009&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  Concat('<a href=\"/cgi-bin/koha/members/boraccount.pl?borrowernumber=', borrowers.borrowernumber, '\" target="_blank">LINK</a>') AS LINK,
  borrowers.cardnumber as BORROWER_CARDNUMBER,
  accountlines.description,
  accountlines.date,
  Format(accountlines.amount, 2) AS amount
FROM
  accountlines
  JOIN borrowers ON accountlines.borrowernumber = borrowers.borrowernumber
WHERE
  concat(accountlines.description, accountlines.note) LIKE CONCAT("%", <<Enter item barcode number>>, "%")
GROUP BY
  borrowers.cardnumber,
  accountlines.accountlines_id
ORDER BY
  accountlines.date DESC



