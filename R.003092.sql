/*
R.003092

----------

Name: GHW - Patron attributes - Collection agency
Created by: George Williams

----------

Group: Borrowers
     Patron attributes

Created on: 2018-06-29 09:12:59
Modified on: 2024-01-17 11:58:02
Date last run: 2024-02-07 13:49:53

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of patrons with contact information based on their "Collection agency" attributes&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows current patrons&lt;/li&gt;
&lt;li&gt;with the home library and collection agency attribute you specify&lt;/li&gt;
&lt;li&gt;grouped by borrower number and attribute&lt;/li&gt;
&lt;li&gt;sorted by patron last name/patron first name&lt;/li&gt;
&lt;li&gt;contains links to the patron's account&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;This report can be used to determine which patrons at your library have a collection agency attribute set.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p id="rquickopen"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3092&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
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
  Coalesce(collectionagency.lib, "~") AS COLLECTION_AGENCY
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
        borrower_attributes.code = 'CAOTTAWA' AND
        authorised_values.category = 'COLLAGEN'
      GROUP BY
        borrower_attributes.borrowernumber,
        borrower_attributes.attribute,
        borrower_attributes.code) collectionagency ON borrowers.borrowernumber = collectionagency.borrowernumber
WHERE
  borrowers.branchcode LIKE &lt;&gt; AND
  borrowers.categorycode LIKE &lt;&gt; AND
  Coalesce(collectionagency.attribute, "~") LIKE &lt;&gt;
GROUP BY
  borrowers.email,
  borrowers.dateofbirth,
  borrowers.borrowernumber,
  borrowers.othernames
ORDER BY
  borrowers.surname,
  borrowers.firstname

























