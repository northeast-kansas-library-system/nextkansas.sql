/*
R.003009

----------

Name: GHW - Accountlines by item barcode number (or description or note keyword)
Created by: George H Williams

----------

Group: Fines/Fees
     -

Created on: 2017-10-23 09:30:01
Modified on: 2022-01-27 08:52:40
Date last run: 2022-12-08 09:19:36

----------

Public: 0
Expiry: 300

----------

<div id='reportinfo' class='noprint'>
<p>Shows accountline information for a particular item if the item's barcode number has been stored in the accountlines description or accountlines note fields</p>
<ul><li>Shows all accountlines related to the item barcode number specified</li>
<li>Shows accountlines related to that item regardless as to which item owns the item or is owed the fee</li>
<li>grouped and sorted by patron barcode number and accountline id</li>
<li>links to the patron's fine history</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report was fully updated on January 21, 2022 to make it do a better job of search both the accountlines description and accountline notes at the same time.</p>
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
  Concat(
    '<a class="btn btn-default noprint" href=\"/cgi-bin/koha/members/boraccount.pl?borrowernumber=', 
    borrowers.borrowernumber, 
    '\" target="_blank">Borrower transactions</a>'
  ) AS LINK,
  borrowers.cardnumber as BORROWER_CARDNUMBER,
  CONCAT_WS(
    ' // ', 
    accountlines.description, 
    accountlines.note
  ) as DESCRIP_NOTES,
  accountlines.date,
  Format(accountlines.amount, 2) AS amount
FROM
  accountlines
  JOIN borrowers ON accountlines.borrowernumber = borrowers.borrowernumber
WHERE
  CONCAT_WS(
    ', ', 
    accountlines.description, 
    accountlines.note
  ) LIKE CONCAT("%", <<Enter item barcode number or other search terms>>, "%")
GROUP BY
  borrowers.cardnumber,
  accountlines.accountlines_id
ORDER BY
  accountlines.date DESC

























