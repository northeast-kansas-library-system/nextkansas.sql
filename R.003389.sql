/*
R.003389

----------

Name: GHW - Open refine ADMINREPORT
Created by: George Williams

----------

Group: -
     -

Created on: 2020-11-30 16:48:41
Modified on: 2025-08-18 13:31:49
Date last run: 2026-01-13 22:51:20

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Outputs borrower address in a way that can be easily imported back into Koha via the patron import tool&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows current borrowers&lt;/li&gt;
&lt;li&gt;at the library you specify&lt;/li&gt;
&lt;li&gt;designed to be flexible&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Notes go here.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3389&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;hidden flexible openrefine&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  UPPER(borrowers.cardnumber) AS cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.country,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateenrolled
FROM
  borrowers
WHERE
  borrowers.branchcode NOT LIKE "HIGH_CC" AND
  /&ast; borrowers.branchcode NOT LIKE "PH%" AND &ast;/
  borrowers.branchcode LIKE &lt;&gt; AND
  borrowers.categorycode &lt;&gt; "STAFF" AND
  borrowers.cardnumber NOT LIKE "0%" AND
  borrowers.cardnumber IS NOT NULL AND
  borrowers.cardnumber NOT LIKE "" AND
  borrowers.address LIKE Concat(&lt;&gt; ,"%") AND
  borrowers.city LIKE Concat(&lt;&gt;, "%") AND
  borrowers.state LIKE Concat(&lt;&gt;, "%")

























