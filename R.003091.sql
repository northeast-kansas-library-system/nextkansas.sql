/*
R.003091

----------

Name: GHW - Patron attributes - Account expired
Created by: George H Williams

----------

Group: Patrons
     Patron attributes

Created on: 2018-06-29 08:57:11
Modified on: 2019-11-21 11:26:22
Date last run: 2019-11-21 11:47:24

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a list of patrons with contact information based on their "Account expired" attributes</p>
<ul><li>Shows current patrons</li>
<li>with the home library and account expired attribute you specify</li>
<li>grouped by borrower number and attribute</li>
<li>sorted by patron last name/patron first name</li>
<li>contains links to the patron's account</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report can be used to determine which patrons at your library have a account expired attribute set.</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3091&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  Concat("<a href='/cgi-bin/koha/circ/circulation.pl?borrowernumber=", borrowers.borrowernumber, "' target='_blank'>Patron</a>") AS LINK_TO_PATRON,
  borrowers.cardnumber,
  Concat_Ws("",
    If(borrowers.surname = "", "-", borrowers.surname), 
    " / ", 
    If(borrowers.firstname = "", "-", borrowers.firstname), 
    If(borrowers.othernames = "", " ", Concat(" - (", borrowers.othernames, ")"))
  ) AS NAME,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.email,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateofbirth,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  Coalesce(expired_account.lib, "~") AS EXPIRATION_FLAGS
FROM
  borrowers
  LEFT JOIN (SELECT
        borrower_attributes.borrowernumber,
        authorised_values.lib,
        borrower_attributes.attribute
      FROM
        borrower_attributes
        JOIN authorised_values ON borrower_attributes.attribute = authorised_values.authorised_value
      WHERE
        borrower_attributes.code = 'EXPIRED' AND
        authorised_values.category = 'EXPIRED'
      GROUP BY
        borrower_attributes.borrowernumber,
        borrower_attributes.attribute,
        borrower_attributes.code) expired_account ON borrowers.borrowernumber = expired_account.borrowernumber
WHERE
  borrowers.branchcode LIKE <<Choose your library|ZBRAN>> AND
  borrowers.categorycode LIKE <<Choose a borrower category|LBORROWERCAT>> AND
  Coalesce(expired_account.attribute, "~") LIKE <<Select expiration attribute|LEXPIRED>>
GROUP BY
  borrowers.email,
  borrowers.dateofbirth,
  borrowers.borrowernumber,
  borrowers.othernames
ORDER BY
  borrowers.dateexpiry,
  borrowers.surname,
  borrowers.firstname



