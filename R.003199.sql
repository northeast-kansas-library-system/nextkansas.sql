/*
R.003199

----------

Name: GHW - Lookup payment details by receipt number
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-05-06 16:00:50
Modified on: 2019-05-06 16:11:32
Date last run: 2021-07-27 14:53:46

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
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
  Concat('<a href=\"/cgi-bin/koha/members/accountline-details.pl?accountlines_id=', accountlines.accountlines_id, '\" target="_blank">LINK</a>') AS LINK_TO_DETAILS,
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
  accountlines.accountlines_id = <<Enter Next Search Catalog receipt number>>
GROUP BY
  accountlines.borrowernumber,
  accountlines.accountlines_id



