/*
R.003209

----------

Name: GHW - Rotating collections - Report 1
Created by: George Williams

----------

Group: -
     -

Created on: 2019-06-10 11:43:41
Modified on: 2024-01-17 11:54:07
Date last run: 2019-06-10 15:06:34

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Identifies all "Rotating collection" groups&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows all current groups&lt;/li&gt;
&lt;li&gt;grouped and sorted by collection ID&lt;/li&gt;
&lt;li&gt;links to the print and edit reports for "Rotating collections"&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p id="rquickopen"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3209&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Concat_WS(
    "",
    Concat("Title: ", collections.colTitle),
    Concat("Description: ", collections.colDesc)
  ) AS COLLECTION,
  Concat('Run report to print') AS PRINT,
  Concat('Run report to batch edit') AS EDIT
FROM
  collections
GROUP BY
  collections.colId
ORDER BY
  collections.colId
DESC
  

























