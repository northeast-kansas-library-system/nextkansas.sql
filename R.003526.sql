/*
R.003526

----------

Name: GHW - Borrowers with unresolved credits
Created by: George H Williams

----------

Group: Fines/Fees
     -

Created on: 2021-07-15 17:11:05
Modified on: 2021-07-15 17:11:05
Date last run: 2021-07-15 17:14:55

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates a list of unresolved credits</p>
<ul><li>Shows currently unresolved credits</li>
<li>at the library you specify</li>
<li>grouped by borrower id number</li>
<li>sorted by library and borrower barcode number</li>
<li>links to the borrower's accounts tab</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>replaces report 831</p>
<p></p>
<p class= "notetags" style="display: none;">#tested #updated  #gk</p>
</div>

----------
*/

SELECT
  branchess.branchname,
  borrowers.cardnumber,
  Format(outstanding_credits.Sum_amountoutstanding, 2) AS TOTAL_UNRESOLVED_CREDITS,
  Concat(
    '<a href=\"/cgi-bin/koha/members/pay.pl?borrowernumber=',
    outstanding_credits.borrowernumber,
    '\" target="_blank">patron fine records</a>'
  ) AS LINK
FROM
  borrowers JOIN
  (SELECT
      accountlines.borrowernumber,
      Sum(accountlines.amountoutstanding) AS Sum_amountoutstanding
    FROM
      accountlines
    WHERE
      accountlines.amountoutstanding < 0
    GROUP BY
      accountlines.borrowernumber) outstanding_credits ON
      outstanding_credits.borrowernumber = borrowers.borrowernumber JOIN
  (SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches) branchess ON branchess.branchcode = borrowers.branchcode
WHERE
  borrowers.branchcode LIKE <<Choose borrower home library|LBRANCH>>
GROUP BY
  borrowers.borrowernumber
ORDER BY
  branchess.branchname,
  borrowers.cardnumber



