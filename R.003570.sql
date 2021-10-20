/*
R.003570

----------

Name: GHW - BPE ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-10-05 18:00:59
Modified on: 2021-10-06 12:24:30
Date last run: 2021-10-11 22:22:14

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
  borrowers.branchcode LIKE <<Choose a library|branches:all>> AND
  borrowers.address LIKE Concat(<<Address>> ,"%") AND
  borrowers.city LIKE Concat(<<City>>, "%") AND
  borrowers.state LIKE Concat(<<State>>, "%") AND
  borrowers.zipcode LIKE Concat(<<Zipcode>>, "%") AND 
  borrowers.zipcode <> Concat(<<Not this zipcode>>)
ORDER BY
  borrowers.zipcode

























