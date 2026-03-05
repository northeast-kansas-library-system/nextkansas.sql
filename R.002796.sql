/*
R.002796

----------

Name: GHW - Duplicate holds on a bibliographic record
Created by: George Williams

----------

Group: Holds-Reserves
     Duplicate request problems

Created on: 2016-10-10 08:59:30
Modified on: 2024-01-17 11:36:18
Date last run: 2023-04-26 11:21:06

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Searches for duplicate patron holds on a bibliographic record&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Searches for current requests&lt;/li&gt;
&lt;li&gt;on a specified biblionumber (text input accepts wildcards)&lt;/li&gt;
&lt;li&gt;grouped by biblionumber and borrowernumber&lt;/li&gt;
&lt;li&gt;sorted by biblionumber and borrowernumber&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;Helpful for identifying duplicate requests caused by merging records.&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2796&phase=Run%20this%20report"  target="_blank"&gt;Click here to run this report in a new window.&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;


----------
*/



SELECT
  reserves.biblionumber,
  reserves.borrowernumber,
  borrowers.surname,
  COUNT(reserves.borrowernumber) AS COUNT_OF_REQUESTS
FROM reserves JOIN borrowers ON reserves.borrowernumber = borrowers.borrowernumber
WHERE (reserves.biblionumber LIKE &lt;&gt;)
GROUP BY reserves.biblionumber, reserves.borrowernumber
HAVING COUNT_OF_REQUESTS &gt; 1

























