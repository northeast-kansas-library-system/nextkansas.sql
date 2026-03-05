/*
R.003280

----------

Name: GHW - Borrower county by library / city / state
Created by: George Williams

----------

Group: -
     -

Created on: 2019-11-08 14:37:15
Modified on: 2024-01-17 12:06:13
Date last run: 2021-12-14 15:22:08

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Counts borrowers by homebranch and city/state&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;counts patrons currently in the system&lt;/li&gt;
&lt;li&gt;at the library you specify, at the group of libraries you specify, or at all libraries&lt;/li&gt;
&lt;li&gt;grouped by borrower home library, borrower city, and borrower state&lt;/li&gt;
&lt;li&gt;sorted by home library, city, and state&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3280&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  information1.HOMEBRANCH,
  information1.city,
  information1.state,
  borrowers_total.Count_borrowernumber AS BORROWERS_TOTAL,
  borrowers_unepired.Count_borrowernumber AS BORROWERS_UNEXPIRED,
  If((borrowers_total.Count_borrowernumber - borrowers_unepired.Count_borrowernumber) = 0, "", (borrowers_total.Count_borrowernumber - borrowers_unepired.Count_borrowernumber)) AS BORROWERS_EXPIRED
FROM
  (
    SELECT
      borrowers.branchcode AS HOMEBRANCH,
      borrowers.city,
      borrowers.state
    FROM
      borrowers
    GROUP BY
      borrowers.branchcode,
      borrowers.city,
      borrowers.state
  ) information1
  INNER JOIN (
    SELECT
      borrowers.branchcode AS HOMEBRANCH,
      borrowers.city,
      borrowers.state,
      Count(borrowers.borrowernumber) AS Count_borrowernumber
    FROM
      borrowers
    GROUP BY
      borrowers.branchcode,
      borrowers.city,
      borrowers.state
  ) borrowers_total
    ON borrowers_total.city = information1.city AND
      borrowers_total.state = information1.state AND
      borrowers_total.HOMEBRANCH = information1.HOMEBRANCH
  LEFT JOIN (
    SELECT
      borrowers.branchcode AS HOMEBRANCH,
      borrowers.city,
      borrowers.state,
      Count(borrowers.borrowernumber) AS Count_borrowernumber
    FROM
      borrowers
    WHERE
      borrowers.dateexpiry &gt;= Now()
    GROUP BY
      borrowers.branchcode,
      borrowers.city,
      borrowers.state
  ) borrowers_unepired
    ON borrowers_unepired.city = information1.city AND
      borrowers_unepired.state = information1.state AND
      borrowers_unepired.HOMEBRANCH = information1.HOMEBRANCH
WHERE
  information1.HOMEBRANCH LIKE &lt;&gt;
GROUP BY
  information1.HOMEBRANCH,
  information1.city,
  information1.state,
  borrowers_total.Count_borrowernumber,
  borrowers_unepired.Count_borrowernumber

























