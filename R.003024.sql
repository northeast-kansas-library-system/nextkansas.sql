/*
R.003024

----------

Name: GHW - Cronjobs by name and date range
Created by: George Williams

----------

Group: -
     -

Created on: 2017-12-27 10:45:27
Modified on: 2024-01-17 11:52:22
Date last run: 2021-07-01 13:32:14

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows the time a cronjob ran on the date specified within the previous 60 days&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows cronojb run times during the date range you specify&lt;/li&gt;
&lt;li&gt;shows runtimes for cronjobs system wide&lt;/li&gt;
&lt;li&gt;grouped by the actionlog ID for the cronjob&lt;/li&gt;
&lt;li&gt;sorted by the date and time the cronjob ran - newest dates to oldest dates&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3024&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Date_Format(action_logs.timestamp, "%Y-%m-%d") AS DATE,
  action_logs.info,
  action_logs.action_id,
  DATE_FORMAT(action_logs.timestamp, '%T') as TIME_OF_DAY
FROM
  action_logs
WHERE
  action_logs.module = 'CRONJOBS' AND
  action_logs.info LIKE &lt;&gt; AND
  action_logs.timestamp BETWEEN &lt;&gt; AND (&lt;&gt; + interval 1 day)
GROUP BY
  action_logs.action_id
ORDER BY
  action_logs.timestamp DESC

























