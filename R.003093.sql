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

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of patrons with contact information based on the "Other attributes 1," "Other attributes 2," and "Registration library" attributes&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows current patrons&lt;/li&gt;
&lt;li&gt;with the home library you specify&lt;/li&gt;
&lt;li&gt;grouped by borrower number and attribute&lt;/li&gt;
&lt;li&gt;sorted by patron last name/patron first name&lt;/li&gt;
&lt;li&gt;contains links to the patron's account&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;This report can be used to determine which patrons at your library have any of these attributes set.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p id="rquickopen"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3093&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

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

























