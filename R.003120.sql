/*
R.003120

----------

Name: GHW - Z39.50 targets
Created by: George Williams

----------

Group: -
     -

Created on: 2018-09-15 11:22:32
Modified on: 2024-01-17 11:57:53
Date last run: 2024-03-06 14:10:09

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates basic Z39.50 list (makes it easy to share with other people)&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows current Z39.50 list used by Next Search Catalog&lt;/li&gt;
&lt;li&gt;does not include Z39.50 targets that require a username/password for access&lt;/li&gt;
&lt;li&gt;grouped by server ID number&lt;/li&gt;
&lt;li&gt;sorted by server type and server name&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Good report for sharing Z39.50 data with other libraries.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p id="rquickopen"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3120&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;p id="rquickdown"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3120"&gt;Click here to download as a csv file&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  z3950servers.servername AS SERVER_NAME,
  z3950servers.host AS HOSTNAME,
  z3950servers.port AS PORT,
  z3950servers.db AS `DATABASE`,
  z3950servers.syntax,
  z3950servers.encoding,
  z3950servers.recordtype AS RECORD_TYPE
FROM
  z3950servers
WHERE
  z3950servers.userid LIKE ""
GROUP BY
  z3950servers.id
ORDER BY
  RECORD_TYPE DESC,
  SERVER_NAME

























