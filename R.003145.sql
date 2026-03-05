/*
R.003145

----------

Name: GHW - ADMINREPORT - Adult patrons with guarantors
Created by: George Williams

----------

Group: -
     -

Created on: 2018-12-17 15:12:26
Modified on: 2024-01-17 11:55:50
Date last run: 2020-07-27 16:21:33

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Adult patrons with lingering guarantor problems&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows patrons who still have guarantor information connected to their accounts even though they are now adults&lt;/li&gt;
&lt;li&gt;Shows patrons at all libraries&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p id="rquickopen"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3145&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;p id="rquickdown"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3145"&gt;Click here to download as a csv file&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.contactname,
  borrowers.contactfirstname,
  borrowers.contacttitle,
  borrowers.relationship,
  borrower_relationships.guarantor_id
FROM
  borrowers LEFT JOIN
  borrower_relationships ON borrower_relationships.guarantee_id =
      borrowers.borrowernumber
WHERE
  (borrowers.dateofbirth &lt;= CurDate() - INTERVAL 18 YEAR OR
      borrowers.dateofbirth IS NULL) AND
  borrower_relationships.guarantor_id IS NOT NULL
GROUP BY
  borrower_relationships.guarantor_id,
  borrowers.borrowernumber

























