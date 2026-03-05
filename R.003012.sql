/*
R.003012

----------

Name: GHW - Unneeded restrictions
Created by: George Williams

----------

Group: Borrowers
     Fix Patrons

Created on: 2017-11-15 16:38:41
Modified on: 2024-01-17 11:52:06
Date last run: 2025-04-10 19:18:33

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows patrons with a restriction on their account that my no longer be justified&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows current restrictions&lt;/li&gt;
&lt;li&gt;shows patrons based on the home library you select when running the report&lt;/li&gt;
&lt;li&gt;grouped by borrowernumber and borrower_debarment_id&lt;/li&gt;
&lt;li&gt;sorted by borrower homebranch and date the restriction was created&lt;/li&gt;
&lt;li&gt;links&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;There are thousands of restrictions that were added manually on 2014.03.12 in an effort to clear up some database issues.  None of the 2014.03.12 restrictions have any comments or notes explaining the reason for the restriction.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3012&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Concat('Link to patron') AS LINK_TO_PATRON,
  borrowers.cardnumber,
  borrowers.branchcode,
  borrower_debarments.created,
  borrower_debarments.updated,
  borrower_debarments.expiration,
  borrower_debarments.type,
  borrower_debarments.comment,
  Concat('Deelte') AS DEELETE
FROM
  borrowers
  LEFT JOIN accountlines ON accountlines.borrowernumber = borrowers.borrowernumber
  LEFT JOIN issues ON issues.borrowernumber = borrowers.borrowernumber
  JOIN borrower_debarments ON borrower_debarments.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode LIKE &lt;&gt;
GROUP BY
  borrowers.borrowernumber,
  borrower_debarments.borrower_debarment_id
HAVING
  Sum(accountlines.amountoutstanding) = 0 AND
  Count(issues.issue_id) = 0
ORDER BY
  borrowers.branchcode,
  borrower_debarments.created

























