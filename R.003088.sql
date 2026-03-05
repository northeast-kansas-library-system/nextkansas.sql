/*
R.003088

----------

Name: GHW - Patron attributes - Internet permissions
Created by: George Williams

----------

Group: Borrowers
     Patron attributes

Created on: 2018-06-29 08:32:01
Modified on: 2024-01-17 11:58:12
Date last run: 2022-03-08 14:23:44

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of patrons with contact information based on their "Internet permission" attributes&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows current patrons&lt;/li&gt;
&lt;li&gt;with the home library and internet permission you specify&lt;/li&gt;
&lt;li&gt;grouped by borrower number and attribute&lt;/li&gt;
&lt;li&gt;sorted by patron last name/patron first name&lt;/li&gt;
&lt;li&gt;contains links to the patron's account&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;This report can be used to determine which patrons at your library have an internet permission attribute set on their account.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p id="rquickopen"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3088&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
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
  Coalesce(internet_permission.lib, "~") AS INTERNET_PERMISSION
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
        borrower_attributes.code = 'INTERNET' AND
        authorised_values.category = 'InternetPolicy'
      GROUP BY
        borrower_attributes.borrowernumber,
        authorised_values.lib,
        borrower_attributes.attribute) internet_permission ON
    borrowers.borrowernumber = internet_permission.borrowernumber
WHERE
  borrowers.branchcode LIKE &lt;&gt; AND
  borrowers.categorycode LIKE &lt;&gt; AND
  Coalesce(internet_permission.attribute, "~") LIKE &lt;&gt;
GROUP BY
  borrowers.borrowernumber,
  Coalesce(internet_permission.lib, "~")
ORDER BY
  borrowers.surname,
  borrowers.firstname

























