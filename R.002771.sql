/*
R.002771

----------

Name: GHW - Card Prefix Report - Part 1
Created by: George Williams

----------

Group: -
     -

Created on: 2016-09-13 18:01:22
Modified on: 2024-12-18 15:46:26
Date last run: 2025-06-11 13:46:35

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Attempts to discern which card number ranges are in use at a specified library&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;reports on current cards in NExpress&lt;/li&gt;
&lt;li&gt;Shows card prefixes at a specified patron homebranch&lt;br /&gt;with a specified number of prefix digits&lt;br /&gt;and where there are more than a specified number of cards with that prefix&lt;/li&gt;
&lt;li&gt;grouped and sorted by patron home library and card number prefix&lt;/li&gt;
&lt;li&gt;click on links to see if other libraries are using this same prefix identified in the report (report 2773)&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;Report 2773 is the companion to this report&lt;/p&gt;
&lt;p&gt;Report created at the request of Robin Hastings.&lt;/p&gt;
&lt;p&gt;Report created by George Williams.&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2771&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  &lt;&gt; AS CARD_PREFIX_LENGTH,
  borrowers.branchcode AS BORROWERS_HOME_BRANCH,
  Left(borrowers.cardnumber, &lt;&gt;) AS LIBRAY_CARD_PREFIX,
  LENGTH(borrowers.cardnumber) AS CARD_NUMBER_LENGTH,
  Count(borrowers.borrowernumber) AS LIBRARY_CARD_COUNT,
  CONCAT(
    'Link to report 2773' 
  ) AS LINK_TO_PREFIX_REPORT_2,
  Concat_WS('',
    'Prefix ',
    Left(borrowers.cardnumber, &lt;&gt;),
    ' / card length ',
    LENGTH(borrowers.cardnumber),
    ' digits (',
    Count(borrowers.borrowernumber),
    ' users) | '
  ) as "PLAIN_ENGLISH"
FROM
  borrowers
WHERE
  borrowers.branchcode LIKE &lt;&gt;
GROUP BY
  borrowers.branchcode, CARD_NUMBER_LENGTH, LIBRAY_CARD_PREFIX
HAVING
  LIBRARY_CARD_COUNT &gt;= &lt;&gt;
ORDER BY
  borrowers.branchcode,
  LIBRAY_CARD_PREFIX

























