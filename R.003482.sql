/*
R.003482

----------

Name: GHW - Phantom restrictions ADMINREPORT
Created by: George Williams

----------

Group: Administrative Reports
     -

Created on: 2021-03-10 14:54:38
Modified on: 2024-01-17 12:00:49
Date last run: 2022-04-04 13:56:38

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Searches for phantom restrictions&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Searches for current instances where data exists in borrowers.debarred but there is no corresponding entry in borrower_debarments.&lt;/li&gt;
&lt;li&gt;grouped and sorted by borrowernumber&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Run once a week to identify borrowers with phantom restrictions.  Then use the batch patron editor to remove all restrictions from the accounts.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="https://northeast-kansas-library-system.github.io/next/bugs/phantom_restrictions.html"   target="_blank"&gt;Training on this report&lt;/a&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3482&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;borrowers restrictions&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.debarred,
  borrowers.debarredcomment,
  borrower_debarments.borrower_debarment_id
FROM
  borrowers LEFT JOIN
  borrower_debarments ON borrower_debarments.borrowernumber =
      borrowers.borrowernumber
WHERE
  borrowers.debarred IS NOT NULL AND
  borrower_debarments.borrower_debarment_id IS NULL
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.borrowernumber

























