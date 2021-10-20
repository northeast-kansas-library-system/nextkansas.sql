/*
R.003086

----------

Name: GHW - Patron attributes - Newsletter permissions
Created by: George H Williams

----------

Group: Borrowers
     Patron attributes

Created on: 2018-06-28 18:09:20
Modified on: 2020-05-08 15:20:19
Date last run: 2021-08-30 15:44:53

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a list of patrons with contact information based on their "Newsletter permission" attributes</p>
<ul><li>Shows current patrons</li>
<li>with the home library and newsletter permission you specify</li>
<li>grouped by borrower number and attribute</li>
<li>sorted by patron last name/patron first name</li>
<li>contains links to the patron's account</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Replaces report 2887 (GHW - Patrons with Newsletter permission flag).</p>
<p></p>
<p>This report can be used to determine which patrons at your library have agreed to let you use their e-mail address from the catalog for the purposes of sending them an e-mail newsletter.</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3086&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Concat(
    "<a href='/cgi-bin/koha/circ/circulation.pl?borrowernumber=", 
    borrowers.borrowernumber, 
    "' target='_blank'>Patron</a>"
  ) AS LINK_TO_PATRON,
  borrowers.cardnumber,
  If(
    Coalesce(newsletter_permission.lib, "~") = "YES", 
    Concat_Ws(
      "", 
      If(borrowers.surname = "", "-", borrowers.surname), 
      " / ", 
      If(borrowers.firstname = "", "-", borrowers.firstname), 
      If(borrowers.othernames = "", " ", Concat(" - (", borrowers.othernames, ")")
      )
    ), "Permission not given"
  ) AS NAME,
  If(
    Coalesce(newsletter_permission.lib, "~") = "YES", 
    Concat(borrowers.address, 
    "<br />", 
    borrowers.address2, 
    "<br />", 
    borrowers.city, 
    ", ",
    borrowers.state, 
    " ", 
    borrowers.zipcode), 
    "Permission not given"
  ) as ADDRESS,
  If(
    Coalesce(newsletter_permission.lib, "~") = "YES", 
    borrowers.email, 
    "Permission not given"
  ) AS email,
  borrowers.branchcode,
  borrowers.categorycode,
  If(
    Coalesce(newsletter_permission.lib, "~") = "YES", 
    borrowers.dateofbirth, 
    "Permission not given"
  ) AS dateofbirth,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  Coalesce(newsletter_permission.lib, "~") AS NEWSLETTER_PERMISSION
FROM
  borrowers LEFT JOIN
  (SELECT
      borrower_attributes.borrowernumber,
      authorised_values.lib,
      borrower_attributes.attribute
    FROM
      borrower_attributes JOIN
      authorised_values ON borrower_attributes.attribute = authorised_values.authorised_value
    WHERE
      borrower_attributes.code = 'NEWSLETTER' AND
      authorised_values.category = 'EmailNews'
    GROUP BY
      borrower_attributes.borrowernumber,
      borrower_attributes.attribute) newsletter_permission ON borrowers.borrowernumber = newsletter_permission.borrowernumber
WHERE
  borrowers.branchcode LIKE <<Choose your library|ZBRAN>> AND
  borrowers.categorycode LIKE <<Choose a borrower category|LBORROWERCAT>> AND
  Coalesce(newsletter_permission.attribute, "~") LIKE <<Select newsletter permission attribute|LNEWSPERM>>
GROUP BY
  Coalesce(newsletter_permission.lib, "~"),
  If(borrowers.email LIKE "%", "X", "Y"),
  borrowers.borrowernumber
ORDER BY
  borrowers.surname,
  borrowers.firstname

























