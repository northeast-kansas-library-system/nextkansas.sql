/*
R.002879

----------

Name: GHW - Tonganoxie 200th patron report
Created by: George Williams

----------

Group:  TONGANOXIE
     -

Created on: 2017-01-06 12:02:25
Modified on: 2024-01-17 11:46:28
Date last run: 2024-09-19 14:26:22

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows an index of patrons with a TONGANOXIE home library during the 2017 calendar year&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows patrons added during 2017&lt;/li&gt;
&lt;li&gt;With a Tonganoxie home branch&lt;/li&gt;
&lt;li&gt;grouped by borrowers.cardnumber, borrowers.dateenrolled, borrowers.borrowernumber&lt;/li&gt;
&lt;li&gt;sorted by patron index number&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2879&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.dateenrolled,
  @curRow := @curRow + 1 AS PATRON_NUMBER
FROM
  borrowers CROSS JOIN
  (SELECT
    @curRow := 0) r
WHERE
  borrowers.branchcode = 'Tonganoxie' AND
  Year(borrowers.dateenrolled) = 2017
GROUP BY
  borrowers.cardnumber, borrowers.dateenrolled, borrowers.borrowernumber
ORDER BY
  PATRON_NUMBER DESC

























