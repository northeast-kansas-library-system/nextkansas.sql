/*
R.003093

----------

Name: GHW - Patron attributes - Other attributes 1 / Other attirbutes 2 / Registration library
Created by: George Williams

----------

Group: Borrowers
     Patron attributes

Created on: 2018-06-29 09:17:52
Modified on: 2024-01-17 11:57:59
Date last run: 2021-02-25 09:48:35

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
<p>Generates a list of patrons with contact information based on the "Other attributes 1," "Other attributes 2," and "Registration library" attributes</p>
<ul><li>Shows current patrons</li>
<li>with the home library you specify</li>
<li>grouped by borrower number and attribute</li>
<li>sorted by patron last name/patron first name</li>
<li>contains links to the patron's account</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report can be used to determine which patrons at your library have any of these attributes set.</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3093&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Concat("Patron") AS LINK_TO_PATRON,
  borrowers.cardnumber,
  Concat_Ws("", If(borrowers.surname = "", "-", borrowers.surname), " / ", If(borrowers.firstname = "", "-", borrowers.firstname), If(borrowers.othernames = "", " ", Concat(" - (", borrowers.othernames, ")"))) AS NAME,
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
  Coalesce(otherinfoone.attribute, "~") AS OTHER_IDENTIFIER_ONE,
  Coalesce(otherinfotwo.attribute, "~") AS OTHER_IDENTIFIER_TWO,
  Coalesce(registrationbranch.attribute, "~") AS REGISTRATION_BRANCH
FROM
  borrowers
  LEFT JOIN (SELECT
        borrower_attributes.borrowernumber,
        borrower_attributes.attribute
      FROM
        borrower_attributes
      WHERE
        borrower_attributes.code = 'ALTID'
      GROUP BY
        borrower_attributes.borrowernumber,
        borrower_attributes.code) otherinfoone ON borrowers.borrowernumber = otherinfoone.borrowernumber
  LEFT JOIN (SELECT
        borrower_attributes.borrowernumber,
        borrower_attributes.attribute
      FROM
        borrower_attributes
      WHERE
        borrower_attributes.code = 'LICENSE'
      GROUP BY
        borrower_attributes.borrowernumber,
        borrower_attributes.code) otherinfotwo ON borrowers.borrowernumber = otherinfotwo.borrowernumber
  LEFT JOIN (SELECT
        borrower_attributes.borrowernumber,
        borrower_attributes.attribute
      FROM
        borrower_attributes
      WHERE
        borrower_attributes.code = 'REGBRANCH'
      GROUP BY
        borrower_attributes.borrowernumber,
        borrower_attributes.code) registrationbranch ON borrowers.borrowernumber = registrationbranch.borrowernumber
WHERE
  borrowers.branchcode LIKE &lt;&gt; AND
  borrowers.categorycode LIKE &lt;&gt; AND
  Coalesce(otherinfoone.attribute, "~") LIKE Concat("%", &lt;&gt;, "%") AND
  Coalesce(otherinfotwo.attribute, "~") LIKE Concat("%", &lt;&gt;, "%") AND
  Coalesce(registrationbranch.attribute, "~") LIKE Concat("%", &lt;&gt;, "%")
GROUP BY
  borrowers.email,
  borrowers.dateofbirth,
  borrowers.borrowernumber,
  borrowers.othernames
ORDER BY
  borrowers.surname,
  borrowers.firstname

























