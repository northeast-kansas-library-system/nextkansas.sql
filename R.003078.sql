/*
R.003078

----------

Name: GHW - List of patrons
Created by: George Williams

----------

Group: Borrowers
     -

Created on: 2018-05-01 22:22:47
Modified on: 2024-01-17 11:58:16
Date last run: 2026-01-09 09:04:03

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of patrons with basic contact information&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Lists all un-deleted patrons - active and expired&lt;/li&gt;
&lt;li&gt;at the library you specify&lt;/li&gt;
&lt;li&gt;grouped by borrowernumber&lt;/li&gt;
&lt;li&gt;sorted by surname, first name, and date of birth&lt;/li&gt;
&lt;li&gt;contains links to the patron record&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3078&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

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
  Concat('Link to patron') AS LINK_TO_PATRON
FROM
  borrowers
WHERE
  borrowers.branchcode LIKE &lt;&gt; AND
  borrowers.categorycode LIKE &lt;&gt;
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.branchcode,
  borrowers.surname,
  borrowers.firstname,
  borrowers.dateofbirth

























