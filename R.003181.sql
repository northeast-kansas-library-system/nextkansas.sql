/*
R.003181

----------

Name: GHW - Checkouts and renewals by title and item type
Created by: George Williams

----------

Group: -
     -

Created on: 2019-03-04 16:13:12
Modified on: 2024-01-17 11:55:01
Date last run: 2024-08-26 22:20:19

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Gives a circulation count by title and item type&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows items checkedout in the previous calendar month&lt;/li&gt;
&lt;li&gt;at the library you specify&lt;/li&gt;
&lt;li&gt;grouped and sorted by library, year, month, itemtype and title&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p id="rquickopen"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3181&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  statistics.branch,
  Year(statistics.datetime) AS YEAR,
  Month(statistics.datetime) AS MONTH,
  itemtypes.description AS ITYPE,
  Coalesce(biblio.title, biblio1.title) AS TITLE,
  Count(&ast;) AS CKO_RENEW_COUNT
FROM
  statistics
  LEFT JOIN items ON items.itemnumber = statistics.itemnumber
  LEFT JOIN deleteditems ON deleteditems.itemnumber = statistics.itemnumber
  LEFT JOIN biblio ON items.biblionumber = biblio.biblionumber
  LEFT JOIN biblio biblio1 ON biblio1.biblionumber = deleteditems.biblionumber
  INNER JOIN itemtypes ON itemtypes.itemtype = statistics.itemtype
WHERE
  statistics.branch LIKE &lt;&gt; AND
  statistics.itemtype LIKE &lt;&gt; AND
  Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
  Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
  (statistics.type = 'ISSUE' OR
    statistics.type = 'RENEW')
GROUP BY
  statistics.branch,
  Year(statistics.datetime),
  Month(statistics.datetime),
  itemtypes.description,
  Coalesce(biblio.title, biblio1.title)
ORDER BY
  statistics.branch,
  YEAR,
  MONTH,
  ITYPE,
  TITLE

























