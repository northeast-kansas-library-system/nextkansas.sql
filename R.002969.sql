/*
R.002969

----------

Name: GHW - Monthly 104
Created by: George Williams

----------

Group: Statistics
     End of month statistics

Created on: 2017-07-01 13:22:33
Modified on: 2024-01-17 11:51:46
Date last run: 2025-06-12 12:28:07

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates end of month data for spreadsheet report&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Reports end of month data for Next-wide spreadsheet - Cells G58, H58, and I58&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p id="rquickdown"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=2969"&gt;Click here to download as a csv file&lt;/a&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;Monthly&lt;/p&gt;
&lt;/div&gt;



----------
*/



SELECT
  'Total biblios on last day of last month' AS DESCRIPTION,
  count(&ast;) AS COUNT
FROM
  biblio
WHERE
  biblio.datecreated &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)
UNION
SELECT
  'Biblios added last month' AS DESCRIPTION,
  Count(&ast;)
FROM
  biblio
WHERE
  Month(biblio.datecreated) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(biblio.datecreated) = Year(Now() - INTERVAL 1 MONTH)
UNION
SELECT
  'Biblios deleted last month' AS DESCRIPTION,
  Count(&ast;)
FROM
  deletedbiblio
WHERE
  Month(deletedbiblio.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(deletedbiblio.timestamp) = Year(Now() - INTERVAL 1 MONTH)

























