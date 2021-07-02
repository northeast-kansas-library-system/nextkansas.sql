/*
R.003389

----------

Name: GHW - Open refine ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-30 16:48:41
Modified on: 2020-12-22 16:33:57
Date last run: 2021-06-15 11:09:11

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Outputs borrower address in a way that can be easily imported back into Koha via the patron import tool</p>
<ul><li>Shows current borrowers</li>
<li>at the library you specify</li>
<li>designed to be flexible</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3389&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">hidden flexible openrefine</p>
</div>

----------
*/

SELECT
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.country,
  borrowers.branchcode,
  borrowers.categorycode
FROM
  borrowers
WHERE
  borrowers.branchcode NOT LIKE "HIGH_CC" AND
  borrowers.branchcode NOT LIKE "PH%" AND
  borrowers.branchcode LIKE <<Choose a library|branches>> AND
  borrowers.categorycode <> "STAFF" AND
  borrowers.cardnumber NOT LIKE "0%" AND
  borrowers.cardnumber IS NOT NULL AND
  borrowers.cardnumber NOT LIKE "" AND
  borrowers.address LIKE Concat(<<Address>> ,"%")



