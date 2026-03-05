/*
R.002779

----------

Name: GHW - Count of current un-expired borrowers at a branch
Created by: George Williams

----------

Group: Borrowers
     -

Created on: 2016-09-27 10:16:31
Modified on: 2024-01-17 11:36:31
Date last run: 2024-07-23 15:34:05

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Counts un-expired borrowers with a specified homebranch&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Counts borrowers currently in NExpress&lt;/li&gt;
&lt;li&gt;with a specified homebranch&lt;/li&gt;
&lt;li&gt;grouped and sorted by borrower's home library&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;/div&gt;

----------
*/



SELECT
  borrowers.branchcode AS BORROWER_HOME_LIBRARY,
  Count(borrowers.borrowernumber) AS COUNT_OF_BORROWERS
FROM
  borrowers
WHERE
  borrowers.dateexpiry &gt; Now() AND
  borrowers.branchcode LIKE &lt;&gt;
GROUP BY
  borrowers.branchcode WITH ROLLUP

























