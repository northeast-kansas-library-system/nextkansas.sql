/*
R.003171

----------

Name: GHW - Closure report 1 - items checked out at a library with due dates during a specified date range
Created by: George Williams

----------

Group: -
     -

Created on: 2019-02-15 11:10:48
Modified on: 2024-01-17 11:55:09
Date last run: 2023-02-04 11:32:29

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Report to get items.itemnumber data for items due in the date range specified&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows itemnumbers for items due on the dates you specify&lt;/li&gt;
&lt;li&gt;at the library you specify&lt;/li&gt;
&lt;li&gt;grouped by branchcode and itemnumber&lt;/li&gt;
&lt;li&gt;sorted by branchcode and date due&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Procedure for NEKLS staff when a library contacts us about an unplanned closure:&lt;br /&gt;&lt;/p&gt;
&lt;ol&gt;
  &lt;li&gt;Run this report for the library that's closing unexpectedly and select the date range that they will be closed&lt;/li&gt;&lt;br /&gt;
  &lt;li&gt;Download the report as a CSV file&lt;/li&gt;&lt;br /&gt;
  &lt;li&gt;Open a support request with ByWater Solutions and attach the csv file to the support request&lt;/li&gt;&lt;br /&gt;
  &lt;li&gt;Ask ByWater to change the due dates on all of the itemnumbers included in the text file to the date the library will re-open (or a day or two after they reopen)&lt;/li&gt;&lt;br /&gt;
  &lt;li&gt;Let the library know that you have asked ByWater to update the due dates on the items that are due during their closure&lt;/li&gt;&lt;br /&gt;
  &lt;li&gt;Follow up with the library and with ByWater if there are any problems or issues&lt;/li&gt;&lt;br /&gt;
&lt;/ol&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p id="rquickopen"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3171&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  issues.branchcode,
  issues.itemnumber,
  issues.date_due
FROM
  issues
WHERE
  issues.date_due BETWEEN &lt;&gt;  AND (&lt;&gt; + interval 1 day) AND
  issues.branchcode LIKE &lt;&gt;
GROUP BY
  issues.branchcode,
  issues.itemnumber
ORDER BY
  issues.branchcode,
  issues.date_due

























