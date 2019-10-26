/*
R.003009

----------

Name: GHW - Accountlines by item barcode number
Created by: George H Williams

----------

Group: Fines/Fees
     -

Created on: 2017-10-23 09:30:01
Modified on: 2019-03-19 12:34:46
Date last run: 2019-10-22 15:03:33

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Shows accountline information for a particular item if the item's barcode number has been stored in the accountlines description field</p>
<ul><li>Shows all accountlines related to the item barcode number specified</li>
<li>Shows accountlines related to that item regardless as to which item owns the item or is owed the fee</li>
<li>grouped and sorted by patron barcode number and accountline id</li>
<li>links to the patron's fine history</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report can only show the fines history on an item if the fee is unpaid or was paid less than 25 months ago.</p>
<p>In older version of Koha, the item barcode number was not always stored in the description field.  If the item's barcode number was not stored in the description field, this report cannot recover the data about the fee history.</p>
<p>This report will show any entries in the patron's fee history - fees, credits, writeoffs, etc.  The only requirement is that the fee description contains the item barcode number you are searching for.</p>
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
  accountlines.description LIKE CONCAT("%", <<Enter item barcode number>>, "%")
GROUP BY
  borrowers.cardnumber,
  accountlines.accountlines_id
ORDER BY
  accountlines.date DESC


