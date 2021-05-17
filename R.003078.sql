/*
R.003078

----------

Name: GHW - List of patrons
Created by: George H Williams

----------

Group: Borrowers
     -

Created on: 2018-05-01 22:22:47
Modified on: 2020-12-30 10:25:35
Date last run: 2021-04-22 15:17:31

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a list of patrons with basic contact information</p>
<ul><li>Lists all un-deleted patrons - active and expired</li>
<li>at the library you specify</li>
<li>grouped by borrowernumber</li>
<li>sorted by surname, first name, and date of birth</li>
<li>contains links to the patron record</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3078&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  borrowers.cardnumber,
  Concat(borrowers.surname, ", ", borrowers.firstname, If(borrowers.othernames = "", "", Concat(" (", borrowers.othernames, ")"))) AS NAME,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.email,
  borrowers.phone,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateofbirth,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  Concat('<a href=\"/cgi-bin/koha/circ/circulation.pl?borrowernumber=', borrowers.borrowernumber, '\" target="_blank">Link to patron</a>') AS LINK_TO_PATRON
FROM
  borrowers
WHERE
  borrowers.branchcode LIKE <<Choose your library|ZBRAN>> AND
  borrowers.categorycode LIKE <<Choose the patron category|LBORROWERCAT>>
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.branchcode,
  borrowers.surname,
  borrowers.firstname,
  borrowers.dateofbirth



