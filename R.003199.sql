/*
R.003199

----------

Name: GHW - Lookup payment details by receipt number
Created by: George Williams

----------

Group: -
     -

Created on: 2019-05-06 16:00:50
Modified on: 2024-01-17 11:54:32
Date last run: 2022-07-20 13:55:06

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
<p>Look up payment and writeoff details by Next Search Catalog receipt number.</p>
<ul><li>Shows payments and writeoffs still logged in the database</li>
<li>grouped by borrowernumber and receipt number</li>
<li>contains a link to the corresponding details page in the patron's fines/fees record</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Details on payments and writeoffs made prior to the addition of the accounts offsets table in 2018 will not include details about which outstanding fees were reconciled by a specific payment.</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3199&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Concat('LINK') AS LINK_TO_DETAILS,
  accountlines.borrowernumber,
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.branchcode
FROM
  accountlines
  JOIN borrowers
    ON accountlines.borrowernumber = borrowers.borrowernumber
WHERE
  accountlines.accountlines_id = &lt;&gt;
GROUP BY
  accountlines.borrowernumber,
  accountlines.accountlines_id

























