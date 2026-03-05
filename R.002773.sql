/*
R.002773

----------

Name: GHW - Card prefix report part 2
Created by: George Williams

----------

Group: -
     -

Created on: 2016-09-14 09:19:42
Modified on: 2024-01-17 11:36:36
Date last run: 2025-06-11 13:47:35

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Attempts to discern which libraries are using a specified card prefix&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;reports on current cards in NExpress&lt;/li&gt;
&lt;li&gt;shows a count of how many cards with the specified prefix exist at all NExpress libraries&lt;/li&gt;
&lt;li&gt;grouped and sorted by patron home library&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;Report 2771 is the companion to this report&lt;/p&gt;
&lt;p&gt;Report created at the request of Robin Hastings.&lt;/p&gt;
&lt;p&gt;Report created by George Williams.&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  borrowers.branchcode AS BORROWERS_HOME_LIBRARY,
  Count(borrowers.cardnumber) AS CARD_COUNT
FROM
  borrowers
WHERE
  borrowers.cardnumber LIKE CONCAT((&lt;&gt;),'%')
GROUP BY
  borrowers.branchcode
  WITH ROLLUP

























